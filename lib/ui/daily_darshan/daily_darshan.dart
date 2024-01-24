import 'package:appstructure/models/daily_darshan_model.dart';
import 'package:appstructure/provider/theme_provider.dart';
import 'package:appstructure/ui/daily_darshan/daily_live_darshan_full_screens.dart';
import 'package:appstructure/ui/daily_darshan/kadi_mandir_darshan.dart';
import 'package:appstructure/ui/daily_darshan/live_darshan_player.dart';
import 'package:appstructure/utils/custom_colors.dart';
import 'package:appstructure/utils/dimentions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class DailyDarshan extends StatefulWidget {
  const DailyDarshan({Key? key, required this.liveJsonList, required this.position}) : super(key: key);
  final List<LiveJson>? liveJsonList;
  final int position;

  @override
  State<DailyDarshan> createState() => _DailyDarshanState();
}

class _DailyDarshanState extends State<DailyDarshan> {
  final List<String> timeList = [
    'Mangala \nDarshan',
    'Shangar \nDarshan',
    'Rajbhog \nDarshan',
    'Sandhya \nDarshan',
    'Shayan \nDarshan',
  ];
  final List<String> imgList = [];
  final List<String> darshanList = [];
  int _currentIndexName = 0;
  int _currentIndexTime = 0;
  List<Widget>? imageSliders;
  final double _height = 75.0.h;
  final _scrollControllerName = ScrollController();
  CarouselController carouselController = CarouselController();
  List<LiveJson>? liveJsonList = [];

  void _scrolltoIndexCarousal(int index, int _currentIndexTime, ThemeProvider themeProvider) {
    carouselController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);

    imgList.clear();
    imageSliders!.clear();
    for (int i = 0; i < liveJsonList!.length; i++) {
      if (liveJsonList![i].images!.isNotEmpty) {
        imgList.add('${liveJsonList![i].images![_currentIndexTime][1].toString()}?t=${liveJsonList![i].images![_currentIndexTime][1].toString()}');
      } else {
        imgList.add('https://sgadiast.nyc3.cdn.digitaloceanspaces.com/placeholder/450X300.jpg');
      }
    }

    imageSliders = imgList.map((item) {
      final index = imgList.indexOf(item);
      return cardViewDailyDarshan('Test', 'desc', true, index, item);
    }).toList();
    setState(() {});
  }

  void _scrollToIndex(int index) {
    //_scrollControllerName.animateTo(index * _height, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    _scrollControllerName.jumpTo(index.toDouble());
  }

  bool isDarkMode() {
    final box = GetStorage();
    if (box.read('Theme') == 'Dark') {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _currentIndexTime = widget.position;
    //   for (int i = 0; i < widget.liveJsonList!.length; i++) {
    //     darshanList.add(widget.liveJsonList![i].title.toString());
    //     if (widget.liveJsonList![i].images!.isNotEmpty) {
    //       imgList.add(widget.liveJsonList![i].images![_currentIndexTime][1].toString());
    //     } else {
    //       imgList.add('https://sgadiast.nyc3.cdn.digitaloceanspaces.com/placeholder/450X300.jpg');
    //     }
    //   }

    //   imageSliders = imgList.map((item) {
    //     final index = imgList.indexOf(item);
    //     return cardViewDailyDarshan('Test', 'desc', true, index, item);
    //   }).toList();

    //   setState(() {});
    // });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _currentIndexTime = widget.position;
      // for (int i = 0; i < widget.liveJsonList!.length; i++) {
      //   darshanList.add(widget.liveJsonList![i].title.toString());
      //   if (widget.liveJsonList![i].images!.isNotEmpty) {
      //     imgList.add(widget.liveJsonList![i].images![_currentIndexTime][1].toString());
      //   } else {
      //     imgList.add('https://sgadiast.nyc3.cdn.digitaloceanspaces.com/placeholder/450X300.jpg');
      //   }
      // }
      // ignore: prefer_final_locals
      Iterable<LiveJson> liveJsonLordSwminarayan = widget.liveJsonList!.where((element) => element.title == 'Lord Swaminarayan');
      liveJsonLordSwminarayan.map((data) {
        liveJsonList?.add(data);
        darshanList.add(data.title.toString());
        if (data.images!.isNotEmpty) {
          imgList.add('${data.images![_currentIndexTime][1].toString()}?t=${DateTime.now().millisecondsSinceEpoch}');
        } else {
          imgList.add('https://sgadiast.nyc3.cdn.digitaloceanspaces.com/placeholder/450X300.jpg');
        }
      }).toList();
      // ignore: prefer_final_locals
      Iterable<LiveJson> liveJsonHarikrishnaMaharaj = widget.liveJsonList!.where((element) => element.title == 'Harikrushna Maharaj');
      liveJsonHarikrishnaMaharaj.map((data) {
        liveJsonList?.add(data);
        darshanList.add(data.title.toString());
        if (data.images!.isNotEmpty) {
          imgList.add('${data.images![_currentIndexTime][1].toString()}?t=${DateTime.now().millisecondsSinceEpoch}');
        } else {
          imgList.add('https://sgadiast.nyc3.cdn.digitaloceanspaces.com/placeholder/450X300.jpg');
        }
      }).toList();
      // ignore: prefer_final_locals
      Iterable<LiveJson> liveJsonSahajanandSwami = widget.liveJsonList!.where((element) => element.title == 'Sahajanand Swami');
      liveJsonSahajanandSwami.map((data) {
        liveJsonList?.add(data);
        darshanList.add(data.title.toString());
        if (data.images!.isNotEmpty) {
          imgList.add('${data.images![_currentIndexTime][1].toString()}?t=${DateTime.now().millisecondsSinceEpoch}');
        } else {
          imgList.add('https://sgadiast.nyc3.cdn.digitaloceanspaces.com/placeholder/450X300.jpg');
        }
      }).toList();

      imageSliders = imgList.map((item) {
        final index = imgList.indexOf(item);
        return cardViewDailyDarshan('Test', 'desc', true, index, item);
      }).toList();

      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                flex: 22,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      if (themeProvider.isDarkMode) const Color(0xFF13161D) else CustomColors.Gradient4.withOpacity(0.00),
                      if (themeProvider.isDarkMode) const Color(0xFF13161D) else CustomColors.Gradient5.withOpacity(0.10),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text('darshan'.tr, style: Theme.of(context).textTheme.displayMedium)
                              ],
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const LiveDarshanPlayer(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: themeProvider.isDarkMode ? const Color(0xFF262829) : const Color(0xFFFFFFFF),
                                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color.fromRGBO(0, 0, 0, 0.08),
                                            blurRadius: 5.0,
                                          ),
                                        ]),
                                    child: Text('Live Maninagar', style: Theme.of(context).textTheme.bodyLarge),
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const KadiMandirDarshan(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: themeProvider.isDarkMode ? const Color(0xFF262829) : const Color(0xFFFFFFFF),
                                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color.fromRGBO(0, 0, 0, 0.08),
                                            blurRadius: 5.0,
                                          ),
                                        ]),
                                    child: Text('Live Kadi', style: Theme.of(context).textTheme.bodyLarge),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: Dimentions.heightMargin10, right: Dimentions.heightMargin10),
                        child: SizedBox(
                          child: _horizontalListDailyDarshanTitle(timeList.length, themeProvider),
                          height: _height,
                        ),
                      ),
                      SizedBox(
                        height: 9.h,
                      ),
                      Container(
                        margin: EdgeInsets.only(right: Dimentions.heightMargin10),
                        child: SizedBox(
                          child: _horizontalListDailyDarshanTitleName(darshanList.length, themeProvider),
                          height: 65.h,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 45,
                child: Container(
                  margin: EdgeInsets.only(top: Dimentions.heightMargin10),
                  color: themeProvider.isDarkMode ? const Color(0xFF0D0D0D).withOpacity(0.70) : const Color(0xFFFFFAF4),
                  child: (imageSliders?.isEmpty ?? true)
                      ? SizedBox(
                          height: 0.65.sh,
                        )
                      : SizedBox(
                          height: 0.65.sh,
                          child: CarouselSlider(
                            carouselController: carouselController,
                            options: CarouselOptions(
                              autoPlay: false,
                              enlargeCenterPage: true,
                              viewportFraction: 0.75,
                              aspectRatio: 0.85,
                              enlargeStrategy: CenterPageEnlargeStrategy.height,
                              scrollDirection: Axis.horizontal,
                              onPageChanged: (index, reason) {
                                _currentIndexName = index;
                                _scrollToIndex(index);
                                setState(() {});
                              },
                            ),
                            items: imageSliders,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardViewDailyDarshan(String title, String desc, bool isNews, int index, String image) {
    String name = '', time = '';
    if (_currentIndexTime == 0) {
      name = 'Mangla Aarti, Divine Darshan';
      time = '5.30am to 6am';
    } else if (_currentIndexTime == 1) {
      name = 'Shangar Aarti, Divine Darshan';
      time = '7:30am to 9am';
    } else if (_currentIndexTime == 2) {
      name = 'Rajbhog Aarti, Divine Darshan';
      time = '9:30am to 11am';
    } else if (_currentIndexTime == 3) {
      name = 'Sandhya Aarti & Niyams';
      time = '4pm onwards';
    } else if (_currentIndexTime == 4) {
      name = 'Shayan Aarti, Divine Darshan';
      time = '8:45pm onwards';
    } else {
      name = 'Mangla Aarti, Divine Darshan';
      time = '5.30am to 6am';
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.only(left: Dimentions.widthMargin20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DailyLiveDarshanFullScreens(
                        galleryItems: imgList,
                        backgroundDecoration: const BoxDecoration(
                          color: Colors.black,
                        ),
                        initialIndex: index,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  child: image != ''
                      ? Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: image,
                              height: 60.sh,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                height: 60.sh,
                                width: MediaQuery.of(context).size.width,
                                child: const Center(child: CircularProgressIndicator()),
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/images/banner_dashboard.jpg',
                                height: 60.sh,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.fullscreen,
                                  size: 25,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        )
                      : Image.asset(
                          'assets/image/banner_dashboard.jpg',
                          height: 60.sh,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium!.apply(color: isDarkMode() ? const Color(0xFFFFE4CB) : const Color(0xFF13161D)),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 3.h),
              child: Text(
                time,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .apply(color: isDarkMode() ? const Color(0xFFFFE4CB).withOpacity(0.60) : const Color(0xFF373A40)),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: Dimentions.heightMargin10),
                child: Image.asset(
                  'assets/images/bottom_line_daily.png',
                  color: isDarkMode() ? const Color(0xFFFFFFFF).withOpacity(0.20) : const Color(0xFFFF8240).withOpacity(0.30),
                )),
          ],
        ),
      ),
    );
  }

  ListView _horizontalListDailyDarshanTitle(int n, ThemeProvider themeProvider) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: n,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, int index) {
        return itemDailyDarshanTitle(timeList[index], index, themeProvider);
      },
    );
  }

  ListView _horizontalListDailyDarshanTitleName(int n, ThemeProvider themeProvider) {
    return ListView.separated(
      controller: _scrollControllerName,
      shrinkWrap: true,
      clipBehavior: Clip.none,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: n,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, int index) {
        return itemDailyDarshanTitleName(darshanList[index], index, themeProvider);
      },
    );
  }

  Widget itemDailyDarshanTitleName(String title, int index, ThemeProvider themeProvider) {
    return GestureDetector(
      onTap: () {
        _currentIndexName = index;
        _scrolltoIndexCarousal(_currentIndexName, _currentIndexTime, themeProvider);
      },
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(left: Dimentions.widthMargin15),
          child: Center(
            child: Column(
              children: [
                Text(
                  title.toUpperCase().replaceAll(' ', '\n'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: index == _currentIndexName
                        ? themeProvider.isDarkMode
                            ? const Color(0xFFFFFFFF)
                            : const Color(0xFFFF8240)
                        : themeProvider.isDarkMode
                            ? const Color(0xFFFFFFFF).withOpacity(0.30)
                            : const Color(0xFF373A40),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Visibility(
                  visible: index == _currentIndexName,
                  child: Image.asset(
                    'assets/images/selected_tab.png',
                    height: 25.h,
                    width: 70.w,
                    fit: BoxFit.fill,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget itemDailyDarshanTitle(String title, int index, ThemeProvider themeProvider) {
    return GestureDetector(
        onTap: () => setState(() {
              _currentIndexTime = index;
              _currentIndexName = 0;
              //_currentIndexName = index;
              _scrolltoIndexCarousal(_currentIndexName, _currentIndexTime, themeProvider);
            }),
        child: Container(
          width: 110.w,
          child: Padding(
            padding: EdgeInsets.only(left: Dimentions.widthMargin15),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  color: index == _currentIndexTime
                      ? const Color(0xFFFF8240)
                      : themeProvider.isDarkMode
                          ? const Color(0xFF1C2126)
                          : const Color(0xFFFFFFFF)),
              child: Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: index == _currentIndexTime
                        ? CustomColors.ColorWhite
                        : themeProvider.isDarkMode
                            ? const Color(0xFFFFFFFF).withOpacity(0.50)
                            : const Color(0xFF373A40),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
