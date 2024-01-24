import 'dart:async';
import 'dart:io';

import 'package:appstructure/data/network/apis/nitya_niyam/nitya_niyam_notifier.dart';
import 'package:appstructure/models/nitya_niyam_model.dart';
import 'package:appstructure/provider/theme_provider.dart';
import 'package:appstructure/utils/custom_colors.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:dialogs/dialogs/choice_dialog.dart';
import 'package:dialogs/dialogs/message_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_seekbar/flutter_advanced_seekbar.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
// ignore: library_prefixes
import 'package:rxdart/rxdart.dart' as RX;
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../../utils/dimentions.dart';

class NityaNiyamDetail extends StatefulWidget {
  const NityaNiyamDetail({
    Key? key,
    this.selectedIndex,
    this.category,
    this.id,
    this.isPlayAll,
  }) : super(key: key);

  final int? selectedIndex;
  final String? category;
  final String? id;
  final bool? isPlayAll;

  @override
  _NityaNiyamDetailState createState() => _NityaNiyamDetailState();
}

enum Language {
  English,
  Gujarati,
}

class _NityaNiyamDetailState extends State<NityaNiyamDetail> with WidgetsBindingObserver {
  int sizeFactor = 60;
  List<NityaNiyamData>? nityaNiyamList;
  bool isLoading = true;
  String languageId = '1';
  late String _localPath;
  late TargetPlatform? platform;
  FontSize? fontSize = FontSize.large;
  late AudioPlayer _audioPlayer;
  List<AudioSource> audioSourceList = [];
  bool isMute = false;

  Stream<PositionData> get _positionDataStream => RX.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _audioPlayer.positionStream,
        _audioPlayer.bufferedPositionStream,
        _audioPlayer.durationStream,
        (position, bufferedPosition, duration) => PositionData(
          position,
          bufferedPosition,
          duration ?? Duration.zero,
        ),
      );

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchNityaNiyamData(widget.category.toString());
    });
    super.initState();
    if (Platform.isAndroid) {
      platform = TargetPlatform.android;
    } else {
      platform = TargetPlatform.iOS;
    }
  }

  Future<void> fetchNityaNiyamData(String id) async {
    final data = Provider.of<NityaNiyamNotifier>(context, listen: false);
    await data.fetchNityaNiyamData(id);
    setState(() {
      nityaNiyamList = data.nityaNiyamModel!.data;
      isLoading = false;
    });
    _audioPlayer = AudioPlayer();
    WidgetsBinding.instance.addObserver(this);
    init();
  }

  Future<void> init() async {
    (nityaNiyamList ?? []).map((data) {
      audioSourceList.add(
        AudioSource.uri(
          Uri.parse(data.audioFile.toString()),
          tag: MediaItem(
            id: data.id ?? '',
            title: data.author.toString(),
          ),
        ),
      );
    }).toList();
    final _playlist = ConcatenatingAudioSource(children: audioSourceList);
    await _audioPlayer.setLoopMode(LoopMode.off);
    await _audioPlayer.setAudioSource(_playlist, initialIndex: widget.selectedIndex, preload: true);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    _audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? SizedBox(
                height: 100.h,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 0,
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
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
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
                                ],
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isMute = !isMute;
                                      });
                                      if (isMute) {
                                        _audioPlayer.setVolume(0);
                                      } else {
                                        _audioPlayer.setVolume(1);
                                      }
                                    },
                                    child: Container(
                                        height: 40,
                                        width: 40,
                                        margin: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: themeProvider.isDarkMode ? const Color(0xFF262829) : const Color(0xFFFFFFFF),
                                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color.fromRGBO(0, 0, 0, 0.08),
                                                blurRadius: 5.0,
                                              ),
                                            ]),
                                        child: Icon(
                                          isMute ? Icons.volume_off : Icons.volume_up,
                                          size: 25,
                                          color: themeProvider.isDarkMode ? const Color(0xFFDADADA) : const Color(0xFF373A40),
                                        )),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(10),
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
                                    child: PopupMenuButton(
                                      offset: const Offset(0, 40),
                                      child: Icon(
                                        Icons.format_size,
                                        size: 25,
                                        color: themeProvider.isDarkMode ? const Color(0xFFDADADA) : const Color(0xFF373A40),
                                      ),
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          child: Container(
                                            width: 200.w,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Text(
                                                      'A',
                                                      style: Theme.of(context).textTheme.bodyLarge,
                                                    ),
                                                    Text(
                                                      'A',
                                                      style: Theme.of(context).textTheme.bodyLarge!.apply(fontSizeDelta: 1.5),
                                                    ),
                                                  ],
                                                ),
                                                AdvancedSeekBar(
                                                  Colors.grey,
                                                  20,
                                                  CustomColors.OrangeColor,
                                                  lineHeight: 5,
                                                  defaultProgress: sizeFactor,
                                                  scaleWhileDrag: true,
                                                  percentSplit: 20,
                                                  percentSplitColor: Colors.grey,
                                                  fillProgress: true,
                                                  autoJump2Split: true,
                                                  seekBarStarted: () {},
                                                  seekBarProgress: (v) {},
                                                  seekBarFinished: (v) {
                                                    if (v >= 1 && v <= 20) {
                                                      fontSize = FontSize.small;
                                                    } else if (v >= 21 && v <= 40) {
                                                      fontSize = FontSize.medium;
                                                    } else if (v >= 41 && v <= 60) {
                                                      fontSize = FontSize.large;
                                                    } else if (v >= 61 && v <= 80) {
                                                      fontSize = FontSize.xLarge;
                                                    } else if (v >= 81 && v <= 100) {
                                                      fontSize = FontSize.xxLarge;
                                                    }

                                                    setState(() {
                                                      sizeFactor = v;
                                                    });
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(10),
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
                                    child: PopupMenuButton(
                                      child: Icon(
                                        Icons.translate,
                                        size: 25,
                                        color: themeProvider.isDarkMode ? const Color(0xFFDADADA) : const Color(0xFF373A40),
                                      ),
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          onTap: () {},
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                'select_language'.tr,
                                                style: Theme.of(context).textTheme.bodyLarge,
                                              ),
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem(
                                          onTap: () {
                                            setState(() {
                                              languageId = '1';
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('english'.tr, style: Theme.of(context).textTheme.bodyLarge),
                                              Radio(
                                                activeColor: CustomColors.OrangeColor,
                                                groupValue: languageId,
                                                onChanged: (value) {},
                                                value: '1',
                                              ),
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem(
                                          onTap: () {
                                            setState(() {
                                              languageId = '2';
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text('gujarati'.tr, style: Theme.of(context).textTheme.bodyLarge),
                                              Radio(
                                                activeColor: CustomColors.OrangeColor,
                                                groupValue: languageId,
                                                value: '2',
                                                onChanged: (value) {},
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              flex: 8,
                              child: StreamBuilder(
                                  stream: _audioPlayer.playbackEventStream,
                                  builder: (context, snapshot) {
                                    return Container(
                                      margin: EdgeInsets.only(left: Dimentions.widthMargin50, right: Dimentions.widthMargin50),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                                            child: Align(
                                              alignment: Alignment.topCenter,
                                              child: Image.asset('assets/images/nitya_niyam_detail_line.png'),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Text(
                                            languageId == '1'
                                                ? nityaNiyamList![_audioPlayer.currentIndex ?? 0].englishNityaNiyam?.title.toString() ?? ''
                                                : nityaNiyamList![_audioPlayer.currentIndex ?? 0].gujaratiNityaNiyam?.title.toString() ?? '',
                                            style: Theme.of(context).textTheme.displayMedium!.apply(
                                                  color:
                                                      themeProvider.isDarkMode ? const Color(0xFFFFFFFF).withOpacity(0.80) : const Color(0xFF373A40),
                                                ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Expanded(
                                            child: SingleChildScrollView(
                                              child: Html(
                                                data: languageId == '1'
                                                    ? nityaNiyamList![_audioPlayer.currentIndex ?? 0].englishNityaNiyam?.text.toString() ?? ''
                                                    : nityaNiyamList![_audioPlayer.currentIndex ?? 0].gujaratiNityaNiyam?.text.toString() ?? '',
                                                style: {
                                                  '#': Style(
                                                    fontSize: fontSize,
                                                    textAlign: TextAlign.left,
                                                    color: themeProvider.isDarkMode
                                                        ? const Color(0xFFFFFFFF).withOpacity(0.80)
                                                        : const Color(0xFF373A40),
                                                  )
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                color: themeProvider.isDarkMode ? const Color(0xFF000000) : const Color(0xFFFFFFFF),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: Column(
                                    children: [
                                      StreamBuilder<PositionData>(
                                        stream: _positionDataStream,
                                        builder: (context, snapshot) {
                                          final positionData = snapshot.data;
                                          return ProgressBar(
                                            barHeight: 8,
                                            baseBarColor: Colors.grey[600],
                                            bufferedBarColor: Colors.grey,
                                            progressBarColor: CustomColors.OrangeColor,
                                            thumbColor: CustomColors.OrangeColor,
                                            timeLabelTextStyle: Theme.of(context).textTheme.bodyLarge!.apply(color: CustomColors.OrangeColor),
                                            progress: positionData?.position ?? Duration.zero,
                                            buffered: positionData?.bufferedPosition ?? Duration.zero,
                                            total: positionData?.duration ?? Duration.zero,
                                            onSeek: _audioPlayer.seek,
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(left: 10, right: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Image.asset(
                                                  'assets/images/share.png',
                                                  color: themeProvider.isDarkMode ? const Color(0xFFDADADA) : const Color(0xFF13161D),
                                                  height: 20.h,
                                                  width: 20.w,
                                                ),
                                              ),
                                              onTap: () {
                                                shareNityaNiyamData('');
                                              },
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                StreamBuilder<SequenceState?>(
                                                  stream: _audioPlayer.sequenceStateStream,
                                                  builder: (context, snapshot) => IconButton(
                                                    icon: Icon(
                                                      Icons.skip_previous,
                                                      size: 30,
                                                      color: themeProvider.isDarkMode
                                                          ? _audioPlayer.hasPrevious
                                                              ? const Color(0xFFDADADA)
                                                              : Colors.grey
                                                          : _audioPlayer.hasPrevious
                                                              ? const Color(0xFF13161D)
                                                              : Colors.grey,
                                                    ),
                                                    onPressed: () {
                                                      if (_audioPlayer.hasPrevious) {
                                                        _audioPlayer.seekToPrevious();
                                                        setState(() {});
                                                      }
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20.w,
                                                ),
                                                StreamBuilder<PlayerState>(
                                                  stream: _audioPlayer.playerStateStream,
                                                  builder: (context, snapshot) {
                                                    final playerState = snapshot.data;
                                                    final processingState = playerState?.processingState;
                                                    final playing = playerState?.playing;
                                                    if (!(playing ?? false)) {
                                                      return GestureDetector(
                                                        onTap: _audioPlayer.play,
                                                        child: Container(
                                                          height: 60.w,
                                                          width: 60.w,
                                                          decoration: const BoxDecoration(
                                                            color: Color(0xFF13161D),
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: const Icon(
                                                            Icons.play_arrow,
                                                            color: Colors.white,
                                                            size: 40,
                                                          ),
                                                        ),
                                                      );
                                                    } else if (processingState != ProcessingState.completed) {
                                                      return GestureDetector(
                                                        onTap: _audioPlayer.pause,
                                                        child: Container(
                                                          height: 60.w,
                                                          width: 60.w,
                                                          decoration: const BoxDecoration(
                                                            color: Color(0xFF13161D),
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: const Icon(
                                                            Icons.pause_rounded,
                                                            color: Colors.white,
                                                            size: 40,
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    return Container(
                                                      height: 40.w,
                                                      width: 40.w,
                                                      decoration: const BoxDecoration(
                                                        color: Color(0xFF13161D),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: const Icon(
                                                        Icons.play_arrow,
                                                        color: Colors.white,
                                                      ),
                                                    );
                                                  },
                                                ),
                                                SizedBox(
                                                  width: 20.w,
                                                ),
                                                StreamBuilder<SequenceState?>(
                                                  stream: _audioPlayer.sequenceStateStream,
                                                  builder: (context, snapshot) => IconButton(
                                                    icon: Icon(
                                                      Icons.skip_next,
                                                      size: 30,
                                                      color: themeProvider.isDarkMode
                                                          ? _audioPlayer.hasNext
                                                              ? const Color(0xFFDADADA)
                                                              : Colors.grey
                                                          : _audioPlayer.hasNext
                                                              ? const Color(0xFF13161D)
                                                              : Colors.grey,
                                                    ),
                                                    onPressed: () {
                                                      if (_audioPlayer.hasNext) {
                                                        _audioPlayer.seekToNext();
                                                        setState(() {});
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            InkWell(
                                              onTap: () async {},
                                              child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Image.asset(
                                                  'assets/images/download.png',
                                                  color: themeProvider.isDarkMode ? const Color(0xFFDADADA) : const Color(0xFF13161D),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Future<void> shareNityaNiyamData(String description) async {
    await FlutterShare.share(title: 'Share Here', text: description);
  }

  ChoiceDialog? choiceDialog;

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
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

    //   final statusStorage = await Permission.storage.status;
    //   final statusManageExternalStorage =
    //       await Permission.manageExternalStorage.status;
    //   if (statusStorage != PermissionStatus.granted) {
    //     final resultStorage = await Permission.storage.request();
    //     if (resultStorage == PermissionStatus.granted) {
    //       if (statusManageExternalStorage != PermissionStatus.granted) {
    //         final resultManageExternalStorage =
    //             await Permission.manageExternalStorage.request();
    //         if (resultManageExternalStorage == PermissionStatus.granted) {
    //           return true;
    //         }
    //       } else {
    //         return true;
    //       }
    //     } else {
    //       if (statusManageExternalStorage != PermissionStatus.granted) {
    //         final resultManageExternalStorage =
    //             await Permission.manageExternalStorage.request();
    //         if (resultManageExternalStorage == PermissionStatus.granted) {
    //           return true;
    //         }
    //       } else {
    //         return true;
    //       }
    //     }
    //   } else {
    //     if (statusManageExternalStorage != PermissionStatus.granted) {
    //       await Permission.manageExternalStorage.request();
    //     } else {
    //       return true;
    //     }
    //   }
    // } else {
    //   return true;
    // }
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

class PositionData {
  PositionData(this.position, this.bufferedPosition, this.duration);
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
}
