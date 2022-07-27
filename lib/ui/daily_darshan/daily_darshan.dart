import 'package:appstructure/ui/widgets/appbar.dart';
import 'package:appstructure/utils/custom_colors.dart';
import 'package:appstructure/utils/dimentions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DailyDarshan extends StatefulWidget {
  const DailyDarshan({Key? key}) : super(key: key);

  @override
  State<DailyDarshan> createState() => _DailyDarshanState();
}

class _DailyDarshanState extends State<DailyDarshan> {
  final List<String> imgList = [
    'assets/images/banner_dashboard.jpg',
    'assets/images/banner_dashboard.jpg',
    'assets/images/banner_dashboard.jpg',
    'assets/images/banner_dashboard.jpg',
    'assets/images/banner_dashboard.jpg',
  ];
  final List<String> darshanList = [
    'Lord \nSwaminaayan',
    'Harikrushna \nMaharaj',
    'Sahajanand \nSwami Maharaj',
    'Jeevanpan \nAbji Bapashree',
    'Muktajivan \nSwamibapa',
  ];
  final List<String> timeList = [
    'Mangala \nDarshan',
    'Shangar \nDarshan',
    'Rajbhog \nDarshan',
    'Sandhya \nDarshan',
    'Shayan \nDarshan',
  ];
  int _currentIndexName = 0;
  int _currentIndexTime = 0;

  late List<Widget> imageSliders = imgList.map((item) {
    var index = imgList.indexOf(item);
    return cardViewDailyDarshan('title', 'desc', true, index);
  }).toList();

  final double _height = 50.0.h;

  final _scrollControllerName = ScrollController();
  CarouselController carouselController = CarouselController();

  void _scrolltoIndexCarousal(int index) {
    carouselController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  void _scrollToIndex(int index) {
    _scrollControllerName.animateTo(index * _height,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(
              left: Dimentions.widthMargin05, right: Dimentions.widthMargin10),
          child: Column(
            children: [
              Expanded(
                flex: 18,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      CustomColors.Gradient4.withOpacity(0.00),
                      CustomColors.Gradient5.withOpacity(0.10)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppBarCustom(
                        title: "Daily Darshan",
                        isNews: false,
                        callback: (){

                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(top: Dimentions.heightMargin10),
                        child: SizedBox(
                          child:
                              _horizontalListDailyDarshanTitle(timeList.length),
                          height: _height,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: Dimentions.heightMargin20),
                        child: SizedBox(
                          child: _horizontalListDailyDarshanTitleName(
                              darshanList.length),
                          height: 52.h,
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
                  child: SizedBox(
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

  Widget cardViewDailyDarshan(
      String title, String desc, bool isNews, int index) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.only(left: Dimentions.widthMargin20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15.r)),
                child: Image.asset(
                  'assets/images/dummy_daily_darshan.png',
                  height: 60.sh,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                'Mangala Aarti, Divine Darshan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: CustomColors.ColorBlack2,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 3.h),
              child: Text(
                '5:30AM to 06:00AM',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: CustomColors.IconColor,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: Dimentions.heightMargin10),
                child: Image.asset('assets/images/bottom_line_daily.png')),
          ],
        ),
      ),
    );
  }

  ListView _horizontalListDailyDarshanTitle(int n) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: n,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, int index) {
        return itemDailyDarshanTitle(timeList[index], index);
      },
    );
  }

  ListView _horizontalListDailyDarshanTitleName(int n) {
    return ListView.separated(
      controller: _scrollControllerName,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: n,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, int index) {
        return itemDailyDarshanTitleName(darshanList[index], index);
      },
    );
  }

  Widget itemDailyDarshanTitleName(String title, int index) {
    return GestureDetector(
      onTap: () {
        _currentIndexName = index;
        _scrolltoIndexCarousal(_currentIndexName);
      },
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(left: Dimentions.widthMargin15),
          child: Center(
            child: Column(
              children: [
                Text(
                  title.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: index == _currentIndexName
                        ? CustomColors.OrangeColor
                        : CustomColors.IconColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Visibility(
                  visible: index == _currentIndexName,
                  child: Image.asset(
                    'assets/images/selected_tab.png',
                    height: 20.h,
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

  Widget itemDailyDarshanTitle(String title, int index) {
    return GestureDetector(
      onTap: () => setState(() {
        _currentIndexTime = index;
        _currentIndexName = 0;
        _scrolltoIndexCarousal(_currentIndexName);
      }),
      child: Container(
        width: 100.w,
        child: Padding(
          padding: EdgeInsets.only(left: Dimentions.widthMargin15),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                color: index == _currentIndexTime
                    ? CustomColors.Gradient3
                    : CustomColors.ColorWhite),
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: index == _currentIndexTime
                      ? CustomColors.ColorWhite
                      : CustomColors.IconColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
