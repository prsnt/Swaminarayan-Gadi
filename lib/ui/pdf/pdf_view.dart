import 'dart:io';

import 'package:appstructure/provider/theme_provider.dart';
import 'package:appstructure/utils/custom_colors.dart';
import 'package:appstructure/utils/dimentions.dart';
import 'package:dialogs/dialogs/message_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class PDFView extends StatefulWidget {
  const PDFView({Key? key, required this.pdfUrl}) : super(key: key);
  final String pdfUrl;

  @override
  _PDFViewState createState() => _PDFViewState();
}

class _PDFViewState extends State<PDFView> {
  late String _localPath;
  late bool _permissionReady;
  late TargetPlatform? platform;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      platform = TargetPlatform.android;
    } else {
      platform = TargetPlatform.iOS;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: themeProvider.isDarkMode ? const Color(0xFF262829) : const Color(0xFFFFFFFF),
                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.08),
                                    blurRadius: 5.0,
                                  ),
                                ]),
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Image.asset(
                                'assets/images/back.png',
                                height: 20,
                                width: 20,
                                color: themeProvider.isDarkMode ? const Color(0xFFDADADA) : const Color(0xFF373A40),
                              ),
                            ),
                            padding: const EdgeInsets.all(10)),
                        Padding(
                          padding: EdgeInsets.only(left: Dimentions.widthMargin10),
                          child: Text('ghanshyam_vijay'.tr, style: Theme.of(context).textTheme.displayMedium),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: themeProvider.isDarkMode ? const Color(0xFF262829) : const Color(0xFFFFFFFF),
                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.08),
                                    blurRadius: 5.0,
                                  ),
                                ]),
                            child: GestureDetector(
                              onTap: () async {
                                // ignore: prefer_final_locals
                                String? file = widget.pdfUrl;
                                // ignore: prefer_final_locals
                                String fileName = file.split('/').last;
                                _permissionReady = await _checkPermission();
                                if (_permissionReady) {
                                  await _prepareSaveDir();
                                  try {
                                    downloadFile(file, fileName, _localPath);
                                  } catch (e) {
                                    debugPrint('Download Failed.\n\n' + e.toString());
                                  }
                                }
                              },
                              child: Image.asset(
                                'assets/images/download.png',
                                height: 20,
                                width: 20,
                                color: themeProvider.isDarkMode ? const Color(0xFFDADADA) : const Color(0xFF373A40),
                              ),
                            ),
                            padding: const EdgeInsets.all(10)),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                color: Colors.white,
                child: Row(
                  children: [
                    const Icon(
                      Icons.info,
                      size: 30,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Pinch to zoom is available.',
                      style: Theme.of(context).textTheme.displayMedium!.apply(
                            color: Colors.black,
                          ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: const PDF(
                fitEachPage: true,
                autoSpacing: true,
                swipeHorizontal: true,
              ).cachedFromUrl(
                widget.pdfUrl,
                placeholder: (progress) => Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        'Downloading $progress%',
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                    ],
                  ),
                ),
                errorWidget: (error) => Center(
                  child: Text(
                    error.toString(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _checkPermission() async {
    if (platform == TargetPlatform.android) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    }
    return false;
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;
    final savedDir = Directory(_localPath);
    // ignore: prefer_final_locals, avoid_slow_async_io
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    if (platform == TargetPlatform.android) {
      //return "/sdcard/download/";
      return (await getExternalStorageDirectory())!.path;
    } else {
      final directory = await getApplicationDocumentsDirectory();
      return directory.path + Platform.pathSeparator + 'Download';
    }
  }

  Future<void> downloadFile(String url, String fileName, String dir) async {
    // ignore: prefer_final_locals
    HttpClient httpClient = HttpClient();
    File file;
    String filePath = '';
    String myUrl = '';
    // ignore: prefer_final_locals
    ProgressDialog pd = ProgressDialog(context: context);
    try {
      pd.show(
        msg: 'Downloading...',
        progressValueColor: CustomColors.OrangeColor,
        progressType: ProgressType.valuable,
        max: 100,
      );
      myUrl = url;
      final request = await httpClient.getUrl(Uri.parse(myUrl));
      final response = await request.close();
      if (response.statusCode == 200) {
        final bytes = await consolidateHttpClientResponseBytes(response);
        filePath = '$dir$fileName';
        file = File(filePath);
        await file.writeAsBytes(bytes);
        pd.close();
      } else {
        filePath = 'Error code: ' + response.statusCode.toString();
      }
      showFileDownloadConfirmDialog(filePath);
    } catch (ex) {
      filePath = 'Can not fetch url';
      pd.close();
    }
  }

  MessageDialog? messageDialog;

  void showFileDownloadConfirmDialog(String filePath) {
    final box = GetStorage();
    if (box.read('Theme') == 'Dark') {
      messageDialog = MessageDialog(
          dialogBackgroundColor: CustomColors.ColorBlack2,
          buttonOkOnPressed: () {
            messageDialog!.dismiss(context);
            openFile(filePath);
          },
          buttonOkColor: CustomColors.ColorBlack,
          title: 'Swaminarayan Gadi',
          titleColor: CustomColors.ColorWhite,
          message: 'Your file path is : $filePath',
          messageColor: CustomColors.ColorWhite,
          buttonOkText: 'OK',
          dialogRadius: 15.r,
          buttonRadius: 15.r);
      messageDialog!.show(context, barrierColor: CustomColors.ColorBlack2);
    } else {
      messageDialog = MessageDialog(
          dialogBackgroundColor: CustomColors.ColorWhite,
          buttonOkOnPressed: () {
            messageDialog!.dismiss(context);
            openFile(filePath);
          },
          buttonOkColor: CustomColors.ColorBlack2,
          title: 'Swaminarayan Gadi',
          titleColor: CustomColors.ColorBlack2,
          message: 'Your file path is : $filePath',
          messageColor: CustomColors.ColorBlack2,
          buttonOkText: 'OK',
          dialogRadius: 15.r,
          buttonRadius: 15.r);
      messageDialog!.show(context, barrierColor: CustomColors.ColorWhite);
    }
  }

  Future<void> openFile(String path) async {
    // ignore: unused_local_variable
    final result = await OpenFilex.open(path);
  }
}
