import 'package:appstructure/data/network/apis/live_darshan/live_darshan_notifier.dart';
import 'package:appstructure/provider/theme_provider.dart';
import 'package:appstructure/ui/widgets/appbar.dart';
import 'package:appstructure/utils/custom_colors.dart';
import 'package:appstructure/utils/dimentions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
//import 'package:fijkplayer_new/fijkplayer_new.dart';
import 'package:liplayer/liplayer.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

class LiveDarshan extends StatefulWidget {
  const LiveDarshan({Key? key}) : super(key: key);

  @override
  State<LiveDarshan> createState() => _LiveDarshanState();
}

class _LiveDarshanState extends State<LiveDarshan> {
  LiPlayer player = LiPlayer();
  CarouselController carouselController = CarouselController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final data = Provider.of<LiveDarshanNotifier>(context, listen: false);
      data.fetchAllLiveData();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    player.release();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: Dimentions.widthMargin05, right: Dimentions.widthMargin10),
          child: Consumer<LiveDarshanNotifier>(
            builder: (context, liveDarshan, _) {
              if (!liveDarshan.loading) {
                return VisibilityDetector(
                  key: const Key('live_darshan'),
                  onVisibilityChanged: (VisibilityInfo info) {
                    if (info.visibleFraction == 0) {
                      if (!player.value.fullScreen) {
                        player.release();
                        liveDarshan.updateIndex(-1);
                      }
                    }
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: AppBarCustom(
                          title: 'live_darshan'.tr,
                          isBack: false,
                          isSearch: false,
                          isFilter: false,
                          backCallback: () {},
                          filterCallBack: () {},
                          searchCallBack: () {},
                        ),
                      ),
                      Expanded(
                        flex: 50,
                        child: Container(
                          margin: EdgeInsets.only(top: Dimentions.heightMargin10),
                          child: SizedBox(
                            height: 0.40.sh,
                            width: MediaQuery.of(context).size.width,
                            child: CarouselSlider.builder(
                              carouselController: carouselController,
                              options: CarouselOptions(
                                autoPlay: false,
                                enlargeCenterPage: true,
                                viewportFraction: 0.80,
                                aspectRatio: 0.85,
                                enlargeStrategy: CenterPageEnlargeStrategy.height,
                                scrollDirection: Axis.horizontal,
                                onPageChanged: (index, reason) {
                                  liveDarshan.updateScrollIndex(index);
                                },
                              ),
                              itemBuilder: (BuildContext context, int index, int realIndex) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: Dimentions.widthMargin20),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(15.r)),
                                      child: liveDarshan.selectedIndex == index
                                          ? LiView(fs: true, fit: LiFit.cover, fsFit: LiFit.cover, player: player)
                                          : Stack(
                                              children: [
                                                CachedNetworkImage(
                                                    imageUrl: liveDarshan.liveJsonList[index].images![1][1].toString(),
                                                    height: 70.sh,
                                                    width: MediaQuery.of(context).size.width,
                                                    fit: BoxFit.cover),
                                                Positioned(
                                                    top: 175,
                                                    right: 100,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        liveDarshan.updateIndex(index);
                                                        liveStreamPlay(liveDarshan.liveJsonList[index].stream.toString());
                                                      },
                                                      child: Image.asset(
                                                        'assets/images/play_button.png',
                                                        color: const Color(0xFFFFFFFF).withOpacity(0.8),
                                                        height: 100.h,
                                                        width: 100.w,
                                                      ),
                                                    ))
                                              ],
                                            ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: liveDarshan.liveJsonList.length,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 20,
                        child: bottomLayout('${liveDarshan.liveJsonList[liveDarshan.scrollIndex].title}', liveDarshan.scrollIndex, themeProvider),
                      ),
                    ],
                  ),
                );
              } else {
                return Column(
                  children: [
                    AppBarCustom(
                      title: 'live_darshan'.tr,
                      isBack: true,
                      isSearch: false,
                      isFilter: false,
                      backCallback: () {
                        Navigator.of(context).pop(true);
                      },
                      filterCallBack: () {},
                      searchCallBack: () {},
                    ),
                    const Expanded(
                        child: Center(
                      child: CircularProgressIndicator(),
                    ))
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget bottomLayout(String title, int index, ThemeProvider themeProvider) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: Dimentions.heightMargin20, left: Dimentions.widthMargin20, right: Dimentions.widthMargin20),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [CustomColors.Gradient3.withOpacity(0.10), CustomColors.Gradient3.withOpacity(0.0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Padding(
        padding: EdgeInsets.only(left: Dimentions.widthMargin20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: Dimentions.heightMargin25),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .apply(color: themeProvider.isDarkMode ? const Color(0xFFFFFFFF) : const Color(0xFF13161D)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 3.h),
              child: Text(
                'Live Darshan in Maninagar Mandir',
                textAlign: TextAlign.center,
                style:
                    Theme.of(context).textTheme.bodyLarge!.apply(color: themeProvider.isDarkMode ? const Color(0xFF96A7AF) : const Color(0xFF13161D)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: always_declare_return_types
  liveStreamPlay(String streamUrl) {
    player.release();
    player = LiPlayer();
    player.setDataSource(
      streamUrl,
      autoPlay: true,
      showCover: true,
    );
    player.prepareAsync();
  }
}
