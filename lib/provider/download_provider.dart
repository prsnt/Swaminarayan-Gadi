import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:appstructure/utils/custom_colors.dart';
import 'package:dialogs/dialogs/message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

enum DownloadStatus { NotStarted, Started, Downloading, Completed }

class FileDownloaderProvider with ChangeNotifier {
  StreamSubscription? _downloadSubscription;
  DownloadStatus _downloadStatus = DownloadStatus.NotStarted;
  int _downloadPercentage = 0;
  String _downloadedFile = '';

  int get downloadPercentage => _downloadPercentage;
  DownloadStatus get downloadStatus => _downloadStatus;
  String get downloadedFile => _downloadedFile;
  String? filePath;

  Future downloadFile(String url, String filename, BuildContext context) async {
    bool _permissionReady = await _checkPermission();
    final Completer<void> completer = Completer<void>();
    // ignore: prefer_final_locals
    ProgressDialog pd = ProgressDialog(context: context);

    if (!_permissionReady) {
      _checkPermission().then((hasGranted) {
        _permissionReady = hasGranted;
      });
    } else {
      pd.show(
        max: 100,
        msg: 'Downloading...',
        progressValueColor: CustomColors.OrangeColor,
        progressType: ProgressType.valuable,
      );
      final httpClient = http.Client();
      final request = http.Request('GET', Uri.parse(url));
      final response = httpClient.send(request);

      final dir = Platform.isAndroid ? '/sdcard/download' : (await getApplicationDocumentsDirectory()).path;

      // ignore: prefer_final_locals
      List<List<int>> chunks = [];
      int downloaded = 0;

      updateDownloadStatus(DownloadStatus.Started);

      _downloadSubscription = response.asStream().listen((http.StreamedResponse r) {
        updateDownloadStatus(DownloadStatus.Downloading);
        r.stream.listen((List<int> chunk) async {
          // Display percentage of completion

          chunks.add(chunk);
          downloaded += chunk.length;

          _downloadPercentage = (downloaded / r.contentLength!.toInt() * 100).round();
          pd.update(value: _downloadPercentage, msg: 'File Downloading...');

          notifyListeners();
        }, onDone: () async {
          // Display percentage of completion
          _downloadPercentage = (downloaded / r.contentLength!.toInt() * 100).round();
          notifyListeners();

          // Save the file
          // ignore: prefer_final_locals
          File file = File('$dir/$filename');

          _downloadedFile = '$dir/$filename';
          filePath = file.absolute.path;

          final Uint8List bytes = Uint8List(r.contentLength!.toInt());
          int offset = 0;
          for (final List<int> chunk in chunks) {
            bytes.setRange(offset, offset + chunk.length, chunk);
            offset += chunk.length;
          }
          await file.writeAsBytes(bytes);

          updateDownloadStatus(DownloadStatus.Completed);
          _downloadSubscription?.cancel();
          _downloadPercentage = 0;
          pd.close();
          showFileDialog(context);
          notifyListeners();
          completer.complete();
          return;
        });
      });
    }

    await completer.future;
  }

  MessageDialog? messageDialog;

  void showFileDialog(BuildContext context) {
    messageDialog = MessageDialog(
        dialogBackgroundColor: Colors.white,
        buttonOkOnPressed: () {
          messageDialog!.dismiss(context);
          //_openFile();
          final Uri uri = Uri.file(filePath!);

          OpenFilex.open(uri.toFilePath());
        },
        buttonOkColor: Colors.black,
        title: 'Swaminarayan Gadi',
        titleColor: Colors.black,
        message: 'Your file path is : $_downloadedFile',
        messageColor: Colors.black,
        buttonOkText: 'Ok',
        dialogRadius: 15.0,
        buttonRadius: 18.0,
        iconButtonOk: const Icon(Icons.one_k));
    messageDialog!.show(context, barrierColor: Colors.white);
  }

  // ignore: unused_element
  void _openFile() {
    OpenFilex.open(filePath);
  }

  void updateDownloadStatus(DownloadStatus status) {
    _downloadStatus = status;
    notifyListeners();
  }

  Future<bool> _checkPermission() async {
    final status = await Permission.storage.status;
    if (status != PermissionStatus.granted) {
      Permission.storage.request();
      // ignore: unrelated_type_equality_checks
      if (Permission.storage.status == PermissionStatus.granted) {
        return true;
      }
    } else {
      return true;
    }

    return false;
  }
}
