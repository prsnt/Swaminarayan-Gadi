import 'package:appstructure/ui/widgets/appbar.dart';
import 'package:appstructure/utils/custom_colors.dart';
import 'package:appstructure/utils/dimentions.dart';
import 'package:appstructure/utils/size_config.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LiveDarshan extends StatefulWidget {
  const LiveDarshan({Key? key}) : super(key: key);

  @override
  State<LiveDarshan> createState() => _LiveDarshanState();
}

class _LiveDarshanState extends State<LiveDarshan> {
  final List<String> imgList = [
    'assets/images/banner_dashboard.jpg',
    'assets/images/banner_dashboard.jpg',
    'assets/images/banner_dashboard.jpg',
    'assets/images/banner_dashboard.jpg',
    'assets/images/banner_dashboard.jpg',
  ];
  final List<String> darshanList = [
    'Lord Swaminaayan',
    'Harikrushna Maharaj',
    'Sahajanand Swami Maharaj',
    'Jeevanpan Abji Bapashree',
    'Muktajivan Swamibapa',
  ];
  CarouselController carouselController = CarouselController();
  int _currentIndexName = 0;
  late List<Widget> imageSliders = imgList.map((item) {
    var index = imgList.indexOf(item);
    return cardViewDailyDarshan('title', 'desc', true, index);
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(
              left: Dimentions.widthMargin05, right: Dimentions.widthMargin10),
          child: Column(
            children: [
              AppBarCustom(
                title: "Live Darshan",
                isNews: false,
                callback: (){

                },
              ),
              Expanded(
                flex: 50,
                child: Container(
                  margin: EdgeInsets.only(top: Dimentions.heightMargin10),
                  child: SizedBox(
                    height: 0.40.sh,
                    width: MediaQuery.of(context).size.width,
                    child: CarouselSlider(
                      carouselController: carouselController,
                      options: CarouselOptions(
                        autoPlay: false,
                        enlargeCenterPage: true,
                        viewportFraction: 0.80,
                        aspectRatio: 0.85,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index, reason) {
                          _currentIndexName = index;
                          setState(() {});
                        },
                      ),
                      items: imageSliders,
                    ),
                  ),
                ),
              ),
              Expanded(flex: 20, child: bottomLayout(darshanList[_currentIndexName], 4)),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomLayout(String title, int index) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: Dimentions.heightMargin20,left: Dimentions.widthMargin20,right:  Dimentions.widthMargin20),
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          CustomColors.Gradient3.withOpacity(0.10),
          CustomColors.Gradient3.withOpacity(0.0)
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))),
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
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: CustomColors.ColorBlack2,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 3.h),
              child: Text(
                'Live Darshan in Maninagar Mandir',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
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

  Widget cardViewDailyDarshan(
      String title, String desc, bool isNews, int index) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.only(left: Dimentions.widthMargin20),
        child: Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
            child: Image.asset(
              'assets/images/dummy_daily_darshan.png',
              height: 70.sh,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
