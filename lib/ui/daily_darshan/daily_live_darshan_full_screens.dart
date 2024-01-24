// ignore_for_file: avoid_slow_async_io

import 'dart:io';

import 'package:appstructure/data/network/apis/api_services.dart';
import 'package:appstructure/provider/theme_provider.dart';
import 'package:appstructure/utils/custom_colors.dart';
import 'package:appstructure/utils/dimentions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dialogs/dialogs/message_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class DailyLiveDarshanFullScreens extends StatefulWidget {
  DailyLiveDarshanFullScreens({
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialIndex = 0,
    required this.galleryItems,
    this.scrollDirection = Axis.horizontal,
  }) : pageController = PageController(initialPage: initialIndex);

  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final List<String> galleryItems;
  final Axis scrollDirection;

  @override
  _DailyLiveDarshanFullScreensState createState() => _DailyLiveDarshanFullScreensState();
}

class _DailyLiveDarshanFullScreensState extends State<DailyLiveDarshanFullScreens> {
  late int currentIndex = widget.initialIndex;
  late String _localPath;
  late bool _permissionReady;
  late TargetPlatform? platform;

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

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
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Container(
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
                            child: Image.asset(
                              'assets/images/back.png',
                              height: 20,
                              width: 20,
                              color: themeProvider.isDarkMode ? const Color(0xFFDADADA) : const Color(0xFF373A40),
                            ),
                            padding: const EdgeInsets.all(10)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: Dimentions.widthMargin10),
                        child: Text('daily_darshan'.tr, style: Theme.of(context).textTheme.displayMedium),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          // ignore: prefer_final_locals
                          String? file = widget.galleryItems[currentIndex];
                          final String fileName = file.split('/').last;
                          _permissionReady = await _checkPermission();
                          if (_permissionReady) {
                            await _prepareSaveDir();
                            try {
                              downloadFile(file, fileName, _localPath);
                            } catch (e) {
                              showToastMessage(e.toString());
                            }
                          }
                        },
                        child: Container(
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
                            child: Image.asset(
                              'assets/images/download.png',
                              height: 20,
                              width: 20,
                              color: themeProvider.isDarkMode ? const Color(0xFFDADADA) : const Color(0xFF373A40),
                            ),
                            padding: const EdgeInsets.all(10)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: _buildItem,
                itemCount: widget.galleryItems.length,
                backgroundDecoration: widget.backgroundDecoration,
                pageController: widget.pageController,
                onPageChanged: onPageChanged,
                scrollDirection: widget.scrollDirection,
              ),
            ),
          ],
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final String item = widget.galleryItems[index];
    return PhotoViewGalleryPageOptions(
      imageProvider: CachedNetworkImageProvider(item),
      initialScale: PhotoViewComputedScale.contained,
      // minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      // maxScale: PhotoViewComputedScale.covered * 4.1,
      heroAttributes: PhotoViewHeroAttributes(tag: item),
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
    final bool hasExisted = await savedDir.exists();
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
    final HttpClient httpClient = HttpClient();
    File file;
    String filePath = '';
    String myUrl = '';
    final ProgressDialog pd = ProgressDialog(context: context);
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
