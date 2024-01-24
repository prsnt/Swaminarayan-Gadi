import 'dart:io';
import 'dart:ui';

import 'package:appstructure/data/network/apis/calender/calender_notifier.dart';
import 'package:appstructure/data/network/apis/daily_darshan/daily_darshan_notifier.dart';
import 'package:appstructure/data/network/apis/daily_quotes/daily_quote_notifier.dart';
import 'package:appstructure/data/network/apis/ghanshyam_vijay/ghanshyam_vijay_notifier.dart';
import 'package:appstructure/data/network/apis/home/home_notifier.dart';
import 'package:appstructure/data/network/apis/live_broadcast/live_broadcast_notifier.dart';
import 'package:appstructure/data/network/apis/news_list/news_list_notifier.dart';
import 'package:appstructure/models/ghanshyam_vijay_model.dart';
import 'package:appstructure/models/home_model.dart';
import 'package:appstructure/models/live_broadcast_model.dart';
import 'package:appstructure/models/news_list_model.dart';
import 'package:appstructure/provider/theme_provider.dart';
import 'package:appstructure/ui/News/news_detail.dart';
import 'package:appstructure/ui/daily_darshan/daily_darshan.dart';
import 'package:appstructure/ui/daily_quotes/daily_quote_detail.dart';
import 'package:appstructure/ui/ghan_shyam_vijay/ghan_shyam_vijay.dart';
import 'package:appstructure/ui/live_darshan/live_broadcast_darshan.dart';
import 'package:appstructure/ui/pdf/pdf_view.dart';
import 'package:appstructure/utils/custom_colors.dart';
import 'package:appstructure/utils/dimentions.dart';
import 'package:appstructure/utils/string_casing_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_store/open_store.dart';
import 'package:provider/provider.dart';
import 'package:version_check/version_check.dart';

import '../daily_quotes/daily_quotes.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  String? version = '';
  String? storeVersion = '';
  String? storeUrl = '';
  String? packageName = '';

  final List<String> imgList = [
    'assets/images/banner_dashboard.jpg',
    'assets/images/banner_dashboard.jpg',
    'assets/images/banner_dashboard.jpg',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchCalenderData();
      getLiveBroadCastData();
      getHomeData();
      getDailyDarshanLiveJsonData();
      getDailyQuoteData();
      getGhanshyamVijayData();
    });
    checkVersion();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  final versionCheck = VersionCheck(
    packageName: Platform.isIOS ? 'com.swaminarayangadi.app' : 'info.sgadi.shangardarshan',
    packageVersion: Platform.isIOS ? '2.3' : '1.10.4',
    showUpdateDialog: customShowUpdateDialog,
    country: 'us',
  );

  Future checkVersion() async {
    await versionCheck.checkVersion(context);
    version = versionCheck.packageVersion;
    packageName = versionCheck.packageName;
    storeVersion = versionCheck.storeVersion;
    storeUrl = versionCheck.storeUrl;
  }

  Future<void> fetchCalenderData() async {
    final data = Provider.of<CalenderNotifier>(context, listen: false);
    await data.fetchCalenderData();
  }

  Future<void> getHomeData() async {
    final data = Provider.of<HomeNotifier>(context, listen: false);
    await data.fetchHomeData();
  }

  Future<void> getGhanshyamVijayData() async {
    final data = Provider.of<GhanshyamVijayNotifier>(context, listen: false);
    await data.fetchGhanShyamVijayHomeData();
  }

  Future<void> getDailyQuoteData() async {
    final data = Provider.of<DailyQuoteNotifier>(context, listen: false);
    await data.fetchDailyQuoteData();
  }

  Future<NewsListModel?> getNewsListData() async {
    final data = Provider.of<NewsListNotifier>(context, listen: false);
    await data.fetchNewsListData();
    return data.newsListModel;
  }

  Future<void> getDailyDarshanLiveJsonData() async {
    final data = Provider.of<DailyDarshanNotifier>(context, listen: false);
    await data.fetchDailyDarshanData();
    await data.fetchDailyDarshanManinagarData();
    await data.fetchAllDailyDarshanData();
  }

  Future<void> getLiveBroadCastData() async {
    final data = Provider.of<LiveBroadCastNotifier>(context, listen: false);
    await data.fetchLiveBroadCastData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(bottom: 40.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Consumer<HomeNotifier>(
                  builder: (context, homeData, _) {
                    if (homeData.loading) {
                      return SizedBox(
                        height: 250.h,
                        width: MediaQuery.of(context).size.width,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return Stack(clipBehavior: Clip.none, children: [
                        topBanner(homeData.homeModel),
                        Positioned(
                          bottom: -30.h,
                          child: Consumer<CalenderNotifier>(builder: (context, calender, _) {
                            return announcementWidget(calender.content.toString(), false);
                          }),
                        ),
                      ]);
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: Dimentions.heightMargin05),
                  child: SizedBox(
                    child: Consumer<DailyDarshanNotifier>(builder: (context, dailyDarshan, _) {
                      if (dailyDarshan.liveJsonList!.isEmpty) {
                        return SizedBox(
                          height: 285.h,
                          child: const Center(child: CircularProgressIndicator()),
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DailyDarshan(
                                      liveJsonList: dailyDarshan.liveJsonList,
                                      position: 0,
                                    ),
                                  ),
                                );
                              },
                              child: titleDailyQuote('daily_darshan'.tr),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Expanded(
                              child: ListView.separated(
                                //cacheExtent: 9999,
                                shrinkWrap: true,
                                padding: EdgeInsets.only(
                                  left: 7.w,
                                  right: 7.w,
                                ),
                                scrollDirection: Axis.horizontal,
                                itemCount: dailyDarshan.liveJsonList?[0].images?.length ?? 0,
                                separatorBuilder: (_, __) => const Divider(),
                                itemBuilder: (context, int index) {
                                  return GestureDetector(
                                      child: itemDailyDarshan(
                                          '${dailyDarshan.liveJsonList![1].images![index][0]}', '${dailyDarshan.liveJsonList![1].images![index][1]}'),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => DailyDarshan(
                                                liveJsonList: dailyDarshan.liveJsonList,
                                                position: index,
                                              ),
                                            ));
                                      });
                                },
                              ),
                            ),
                          ],
                        );
                      }
                    }),
                    height: 285.h,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Dimentions.heightMargin15),
                  child: titleViewAll('daily_quotes'.tr),
                ),
                Consumer<DailyQuoteNotifier?>(
                  builder: (context, dailyQuote, _) {
                    if (dailyQuote?.loading ?? true) {
                      return SizedBox(
                        height: 170.h,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return Container(
                        margin: EdgeInsets.only(
                          left: Dimentions.widthMargin15,
                          right: Dimentions.widthMargin15,
                          top: Dimentions.heightMargin05,
                        ),
                        child: SizedBox(
                          height: 170.h,
                          child: cardViewDailyQuote(
                            dailyQuote?.dailyQuoteModel?.mainData?.data?[0].desc ?? '',
                            dailyQuote?.dailyQuoteModel?.mainData?.data?[0].author ?? '',
                          ),
                        ),
                      );
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: Dimentions.heightMargin15),
                  child: titleViewAll('ghanshyam_vijay'.tr),
                ),
                Container(
                  margin: EdgeInsets.only(top: Dimentions.heightMargin10),
                  child: Consumer<GhanshyamVijayNotifier>(
                    builder: (context, ghanShyamVijay, _) {
                      if (ghanShyamVijay.isHomeLoading) {
                        return SizedBox(
                          height: 240.h,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else {
                        return SizedBox(
                          child: _horizontalListGV(ghanShyamVijay.ghanshyamVijayModel ?? GhanshyamVijayModel()),
                          height: 240.h,
                        );
                      }
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: Dimentions.widthMargin20,
                      top: Dimentions.heightMargin10,
                      right: Dimentions.widthMargin20,
                      bottom: Dimentions.heightMargin05),
                  child: Text(
                    'guru_parampara'.tr,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                Consumer<HomeNotifier>(
                  builder: (context, homeData, _) {
                    if (homeData.loading) {
                      return SizedBox(
                        height: 250.h,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      List<ImageJson>? guruParamParaList = [];
                      (homeData.homeModel?.data ?? []).map((data) {
                        if (data.title!.contains('Guruparampara') && data.tSlider == '4_column_popup') {
                          guruParamParaList = data.imageJson;
                        }
                      }).toList();
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: GridView.builder(
                              itemCount: guruParamParaList?.length ?? 0,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 0.85,
                                  crossAxisSpacing: Dimentions.heightMargin10,
                                  mainAxisSpacing: Dimentions.heightMargin10),
                              itemBuilder: (context, index) {
                                return Center(
                                  child: itemGuruParampara(
                                    guruParamParaList?[index].imageurl,
                                    guruParamParaList?[index].sTitle,
                                  ),
                                );
                              }),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListView _horizontalListGV(GhanshyamVijayModel ghanshyamVijayModel) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      addAutomaticKeepAlives: true,
      padding: EdgeInsets.only(
        left: 7.w,
        right: 7.w,
      ),
      itemCount: 5,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, int index) {
        return itemGhanshyamVijay(
          ghanshyamVijayModel.mainData?.data?[index].publishOn ?? '',
          ghanshyamVijayModel.mainData?.data?[index].bannerImage ?? '',
          ghanshyamVijayModel.mainData?.data?[index].pdfFile ?? '',
        );
      },
    );
  }

  Widget itemGuruParampara(String? imageUrl, String? title) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          ClipOval(
            child: CachedNetworkImage(
              height: 90.w,
              width: 90.w,
              fit: BoxFit.fill,
              imageUrl: imageUrl!,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                title!.capitalizeFirstofEach(),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style:
                    Theme.of(context).textTheme.bodyLarge!.apply(color: themeProvider.isDarkMode ? const Color(0xFFEED2AD) : const Color(0xFF5B5D62)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemDailyDarshan(String? title, String? image) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      height: 210.h,
      width: 170.w,
      child: Padding(
        padding: EdgeInsets.only(
          left: 7.w,
          right: 7.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20.r)),
              child: CachedNetworkImage(
                imageUrl: image.toString(),
                imageBuilder: (context, imageProvider) => Container(
                  height: 190.h,
                  width: 150.w,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => Container(
                  height: 190.h,
                  width: 150.w,
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/images/banner_dashboard.jpg',
                  height: 190.h,
                  width: 150.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                title.toString(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.apply(
                      fontSizeDelta: 1.5,
                      color: themeProvider.isDarkMode ? const Color(0xFFEED2AD) : const Color(0xFF5B5D62),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemWhatTheySay(String? title, String? imageUrl) {
    return Padding(
      padding: EdgeInsets.only(left: Dimentions.widthMargin20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
            child: CachedNetworkImage(
              height: 180.h,
              width: 270.w,
              imageUrl: imageUrl!,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: 240.w,
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.symmetric(vertical: Dimentions.heightMargin10),
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 06.0, sigmaY: 06.0),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: Colors.white.withOpacity(0.25)),
                  child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10.w, horizontal: 30.w),
                      child: Text(
                        textAlign: TextAlign.center,
                        title!.toUpperCase(),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: CustomColors.ColorWhite,
                        ),
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemGhanshyamVijay(String title, String imageUrl, String pdfFile) {
    // ignore: prefer_final_locals
    DateTime tempDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(title);
    final inputDate = DateTime.parse(tempDate.toString());
    final outputFormat = DateFormat('MMM yyyy');
    final outputDate = outputFormat.format(inputDate);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PDFView(pdfUrl: pdfFile),
          ),
        );
      },
      child: Container(
        height: 210.h,
        width: 170.w,
        child: Padding(
          padding: EdgeInsets.only(
            left: 7.w,
            right: 7.w,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 190.h,
                width: 150.w,
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20.r)),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      imageBuilder: (context, imageProvider) => Container(
                        height: 190.h,
                        width: 150.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Container(
                        height: 190.h,
                        width: 150.w,
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/images/banner_dashboard.jpg',
                        height: 190.h,
                        width: 150.w,
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
              //),
              announcementWidget(outputDate, true),
            ],
          ),
        ),
      ),
    );
  }

  Widget topBanner(HomeModel? homeModel) {
    String imageUrl = '';
    (homeModel?.data ?? []).map((data) {
      if (data.title == 'Slider' && data.tSlider == 'full') {
        imageUrl = data.imageJson?[0].imageurl ?? '';
      }
    }).toList();

    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: double.infinity, maxHeight: 250.h),
      child: Stack(children: [
        Container(
            height: 250.h,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(25.r)),
              child: Image.network(imageUrl,
                  errorBuilder: (context, exception, stackTrace) {
                    return Image.asset(
                      'assets/images/banner_dashboard.jpg',
                      height: 250.h,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    );
                  },
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Container(
                      height: 250.h,
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }),
            )),
        Container(
            height: 250.h,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(50.r)),
              child: Image.asset(
                'assets/images/banner_dashboard_hover.png',
                fit: BoxFit.cover,
              ),
            )),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: Dimentions.heightMargin10),
            child: Text(
              'Shree Swaminarayan Gadi \nSansthan',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium!.apply(
                    color: const Color(0xFFFFFFFF),
                  ),
            ),
          ),
        ),
      ]),
    );
  }

  String? getYoutubeThumbnail(String videoUrl) {
    final Uri uri = Uri.parse(videoUrl);
    // ignore: unnecessary_null_comparison
    if (uri == null) {
      return null;
    }
    return 'https://img.youtube.com/vi/${uri.queryParameters['v']}/0.jpg';
  }

  Widget cardViewLive(LiveBroadCastData liveBroadCastData) {
    // ignore: prefer_final_locals
    String? thumbNail = getYoutubeThumbnail('https://www.youtube.com/watch?v=${liveBroadCastData.streamId}');
    // ignore: prefer_final_locals
    DateTime tempDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(liveBroadCastData.createdDate.toString());
    final inputDate = DateTime.parse(tempDate.toString());
    final outputDayFormat = DateFormat('EEE dd MMM | hh:mm');
    final date = '${outputDayFormat.format(inputDate)} IST';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LiveBroadCastDarshan(
              youtubeId: liveBroadCastData.streamId.toString(),
            ),
          ),
        );
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15.r)),
              // child: Image.asset(
              //   'assets/images/banner_dashboard.jpg',
              //   fit: BoxFit.cover,
              // ),

              child: CachedNetworkImage(
                imageUrl: thumbNail.toString(),
                fit: BoxFit.cover,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15.r)),
              child: Image.asset(
                'assets/images/dashboard_card_hover.png',
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: Dimentions.widthMargin15, vertical: Dimentions.heightMargin15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 250.w,
                          child: Text(
                            '${liveBroadCastData.name}',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: CustomColors.ColorWhite,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3.0.h),
                          child: Text(
                            date,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Image.asset(
                      'assets/images/play_icon.png',
                      width: Dimentions.widthMargin20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cardViewNews(String? id, String? image, String? title, String? desc, String? date) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsDetail(
                title: title,
                date: date,
                image: image,
                id: id,
              ),
            ));
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15.r)),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15.r)),
                child: CachedNetworkImage(
                  imageUrl: image.toString(),
                  imageBuilder: (context, imageProvider) => Container(
                    height: 170.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Container(
                    height: 170.h,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/banner_dashboard.jpg',
                    height: 170.h,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(15.r),
              ),
              child: Image.asset(
                'assets/images/dashboard_card_hover.png',
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: CustomColors.OrangeColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15.r),
                    topLeft: Radius.circular(15.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Dimentions.heightMargin05,
                    horizontal: Dimentions.widthMargin20,
                  ),
                  child: Text(
                    'Latest News'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: CustomColors.ColorWhite,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: Dimentions.widthMargin20,
                  vertical: Dimentions.heightMargin20,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            overflow: TextOverflow.ellipsis,
                            title!,
                            softWrap: false,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: CustomColors.ColorWhite,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0.h),
                            child: Text(
                              desc!,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white.withOpacity(0.7),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            shareNewsData(title, desc);
                          },
                          child: Container(
                            height: 24.w,
                            width: 24.w,
                            child: Image.asset(
                              'assets/images/share.png',
                              width: Dimentions.widthMargin20,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> shareNewsData(String title, String desc) async {
    // ignore: prefer_final_locals
    String? data = '$title \n\n $desc';
    await FlutterShare.share(title: 'Share Here', text: data);
  }

  Widget cardViewDailyQuote(String? quote, String? name) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DailyQuoteDetail(
              quote: quote.toString(),
              author: name.toString(),
            ),
          ),
        );
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30.r)),
            child: Image.asset(
              'assets/images/quote_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30.r)),
            child: Image.asset(
              'assets/images/quote_black_layer.png',
              fit: BoxFit.cover,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30.r)),
            child: Image.asset(
              'assets/images/quote_orange_hover.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Image.asset(
                  'assets/images/starting_quote.png',
                  height: 25.h,
                  width: 25.w,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Container(
                            child: Image.asset(
                              alignment: AlignmentDirectional.centerStart,
                              'assets/images/standing_line_dq.png',
                              height: 20,
                              width: 10,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 40,
                        child: Text(
                          quote!,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: CustomColors.ColorWhite,
                            fontSize: 17.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(),
                      ),
                      Expanded(
                        flex: 50,
                        child: Text(
                          '- ${name!}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: Image.asset(
                    'assets/images/ending_quote_icon.png',
                    height: 25.h,
                    width: 25.w,
                  ),
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget titleDailyQuote(String title) {
    return Container(
      margin: EdgeInsets.only(
        left: Dimentions.widthMargin20,
        right: Dimentions.widthMargin20,
        top: Dimentions.heightMargin20,
      ),
      child: Text(
        '${title.toUpperCase()} (Live)',
        style: Theme.of(context).textTheme.displaySmall!.copyWith(
              decoration: TextDecoration.underline,
            ),
      ),
    );
  }

  Widget titleViewAll(String title) {
    return Container(
      margin: EdgeInsets.only(
        left: Dimentions.widthMargin20,
        top: Dimentions.heightMargin10,
        bottom: Dimentions.heightMargin10,
        right: Dimentions.widthMargin20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.displaySmall,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (title == 'ghanshyam_vijay'.tr) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GhanShyamVijay(isFromNotification: false),
                      ),
                    );
                  } else if (title == 'daily_quotes'.tr) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DailyQuotes(),
                      ),
                    );
                  }
                },
                child: Text(
                  'view_all'.tr,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15.w,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget announcementWidget(String text, bool isGV) {
    if (text.isEmpty) {
      return const SizedBox();
    }
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Dimentions.widthMargin20,
      ),
      child: FractionalTranslation(
        translation: const Offset(0.0, -0.5),
        child: Align(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: isGV ? BorderRadius.circular(10.r) : BorderRadius.circular(15.r),
                  color: Theme.of(context).colorScheme.secondary,
                  boxShadow: [
                    BoxShadow(
                      color: CustomColors.ColorBlack2.withOpacity(.04),
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: Offset(0, Dimentions.widthMargin05),
                    )
                  ]),
              child: Padding(
                padding: EdgeInsets.only(
                  left: Dimentions.widthMargin10,
                  right: Dimentions.widthMargin10,
                  top: Dimentions.widthMargin10,
                  bottom: Dimentions.widthMargin10,
                ),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
            alignment: isGV ? Alignment.topCenter : Alignment.topLeft),
      ),
    );
  }
}

void customShowUpdateDialog(BuildContext context, VersionCheck versionCheck) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        title: const Text('New Update Available'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Looks like you have an older version of the application. Please update to get the latest features and best experience.')
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Update'),
            onPressed: () async {
              OpenStore.instance.open(
                appStoreId: '1443539089', // AppStore id of your app for iOS
                androidAppBundleId: 'info.sgadi.shangardarshan', // Android app bundle package name
              );
            },
          ),
          // TextButton(
          //   child: const Text('Exit'),
          //   onPressed: () {
          //     SystemNavigator.pop();
          //   },
          // ),
        ],
      ),
    ),
  );
}
