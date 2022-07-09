import 'dart:ffi';
import 'dart:ui';

import 'package:appstructure/utils/custom_colors.dart';
import 'package:appstructure/utils/dimentions.dart';
import 'package:appstructure/utils/size_config.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _current = 0;
  final List<String> imgList = [
    'assets/images/banner_dashboard.jpg',
    'assets/images/banner_dashboard.jpg',
    'assets/images/banner_dashboard.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.ColorWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              topBanner(),
              announcementWidget('Today is Ekadasi', false),
              titleViewAll('Live Broadcast'),
              Container(
                margin: EdgeInsets.only(
                    top: Dimentions.heightMargin05,
                    left: Dimentions.widthMargin15,
                    right: Dimentions.widthMargin15),
                width: MediaQuery.of(context).size.width,
                child: CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: false,
                    height: 170.h,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: imageSliders,
                ),
              ),
              indicatorView(imgList),
              titleDailyQuote('Daily Darshan'),
              Padding(
                padding: EdgeInsets.only(top: Dimentions.heightMargin05),
                child: SizedBox(
                  child: _horizontalListDD(5),
                  height: 220.h,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: Dimentions.heightMargin15),
                child: titleViewAll('Daily Quotes'),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: Dimentions.widthMargin15,
                  right: Dimentions.widthMargin15,
                  top: Dimentions.heightMargin05,
                ),
                child: SizedBox(
                    height: 170.h,
                    child: cardViewDailyQuote(
                        'Satsang is like a wish-fulfilling tree; one attains whatever is desired.',
                        '- Purushotampriyadasji Swami Maharaj')),
              ),
              Padding(
                padding: EdgeInsets.only(top: Dimentions.heightMargin15),
                child: titleViewAll('Ghanshyam Vijay'),
              ),
              Container(
                margin: EdgeInsets.only(top: Dimentions.heightMargin10),
                child: SizedBox(
                  child: _horizontalListGV(5),
                  height: 240.h,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: Dimentions.widthMargin20,
                    top: Dimentions.heightMargin10,
                    right: Dimentions.widthMargin20,
                    bottom: Dimentions.heightMargin05),
                child: Text(
                  'Guru Parampara'.toUpperCase(),
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              GridView.count(
                crossAxisCount: 3,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                mainAxisSpacing: Dimentions.heightMargin10,
                children: List.generate(8, (index) {
                  return Center(
                      child: itemGuruParampara(
                          'imageUrl', 'Lord Shree Swaminarayan'));
                }),
              ),
              titleViewAll('What they say'),
              Padding(
                padding: EdgeInsets.only(top: Dimentions.heightMargin10),
                child: SizedBox(
                  child: _horizontalListWTS(5),
                  height: 180.h,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimentions.widthMargin15,
                    vertical: Dimentions.heightMargin25),
                child: SizedBox(
                    height: 170,
                    width: MediaQuery.of(context).size.width,
                    child: cardViewNews('title', 'desc')),
              )
            ],
          ),
        ),
      ),
    );
  }

  ListView _horizontalListWTS(int n) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: n,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, int index) {
        return itemWhatTheySay('Mangala Darshan');
      },
    );
  }

  ListView _horizontalListDD(int n) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: n,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, int index) {
        return itemDailyDarshan('Mangala Darshan');
      },
    );
  }

  ListView _horizontalListGV(int n) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: n,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, int index) {
        return itemGhanshyamVijay('May 2022');
      },
    );
  }

  late List<Widget> imageSliders =
      imgList.map((item) => cardViewLive('title', 'desc', true)).toList();

  Widget itemGuruParampara(String imageUrl, String title) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/ghanshyam_maharaj.png',
            height: 90.w,
            width: 90.w,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: CustomColors.FontColorGray2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemDailyDarshan(String title) {
    return Container(
      height: 210.h,
      width: 170.w,
      child: Padding(
        padding: EdgeInsets.only(left: Dimentions.widthMargin15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20.r)),
              child: Image.asset(
                'assets/images/banner_dashboard.jpg',
                height: 190.h,
                width: 150.w,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                'Mangala Darshan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: CustomColors.FontColorGray2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemWhatTheySay(String title) {
    return Padding(
      padding: EdgeInsets.only(left: Dimentions.widthMargin20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30.r)),
            child: Image.asset(
              height: 180.h,
              width: 270.w,
              'assets/images/modi.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            // The Positioned widget is used to position the text inside the Stack widget
            width: 220.w,
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.symmetric(vertical: Dimentions.heightMargin10),
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 06.0, sigmaY: 06.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: Colors.white.withOpacity(0.25)),
                  child: Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 10.w, horizontal: 30.w),
                      child: Text(
                        textAlign: TextAlign.center,
                        "India's Prime Minister Shri Narendra Modi"
                            .toUpperCase(),
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

  Widget itemGhanshyamVijay(String title) {
    return Container(
      height: 210.h,
      width: 170.w,
      child: Padding(
        padding: EdgeInsets.only(left: Dimentions.widthMargin15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 190.h,
              width: 150.w,
              /*child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.r)),
                    side: BorderSide(width: 1, color: Color(0xFFFF8240).withOpacity(0.15))),*/
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20.r)),
                child: Image.asset(
                  height: 190.h,
                  width: 150.w,
                  'assets/images/ghanshyam_vijay.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //),
            announcementWidget(title, true),
          ],
        ),
      ),
    );
  }

  Widget indicatorView(List<String> imgList) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: imgList.asMap().entries.map((entry) {
        return GestureDetector(
          onTap: () => null,
          child: Container(
            width: 10.w,
            height: 10.w,
            margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (Theme.of(context).brightness == Brightness.dark
                        ? CustomColors.OrangeColor
                        : CustomColors.OrangeColor)
                    .withOpacity(_current == entry.key ? 1 : 0.4)),
          ),
        );
      }).toList(),
    );
  }

  Widget topBanner() {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: double.infinity, maxHeight: 250.h),
      child: Stack(children: [
        Container(
            height: 250.h,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(50.r)),
              child: Image.asset(
                'assets/images/banner_dashboard.jpg',
                fit: BoxFit.cover,
              ),
            )),
        Container(
            height: 250.h,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(50.r)),
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
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: CustomColors.ColorWhite,
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget cardViewLive(String title, String desc, bool isNews) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30.r)),
            child: Image.asset(
              'assets/images/banner_dashboard.jpg',
              fit: BoxFit.cover,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30.r)),
            child: Image.asset(
              'assets/images/dashboard_card_hover.png',
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: Dimentions.widthMargin15,
                  vertical: Dimentions.heightMargin15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Maninagar Evening Katha',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: CustomColors.ColorWhite,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 3.0.h),
                        child: Text(
                          'Sat 14th May | 7.45PM IST',
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
    );
  }

  Widget cardViewNews(String title, String desc) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30.r)),
            child: Image.asset(
              'assets/images/banner_dashboard.jpg',
              fit: BoxFit.cover,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30.r)),
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
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(30.r),topLeft: Radius.circular(30.r))),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: Dimentions.heightMargin05,horizontal: Dimentions.widthMargin20),
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
                  vertical: Dimentions.heightMargin20),
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
                          'Jeevanpran Shree Abji Bapashree Jayanti - Maninagar Dham',
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
                            'Sat 14th May | 7.45PM IST',
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
                      Container(
                        height: 24.w,
                        width: 24.w,
                        child: Image.asset(
                          'assets/images/share.png',
                          width: Dimentions.widthMargin20,
                        ),
                      ),
                      Container(
                        height: 24.w,
                        width: 24.w,
                        margin: EdgeInsets.only(left: Dimentions.widthMargin10),
                        child: Image.asset(
                          'assets/images/play_icon.png',
                          width: Dimentions.widthMargin20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget cardViewDailyQuote(String quote, String name) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.r),
      ),
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
            margin: const EdgeInsets.all(25.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Image.asset('assets/images/starting_quote.png'),
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
                        quote,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: CustomColors.ColorWhite,
                            fontSize: 17.sp),
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
                      child: Text(name,
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white.withOpacity(0.7))),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: AlignmentDirectional.bottomEnd,
                child: Image.asset(
                  'assets/images/ending_quote_icon.png',
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }

  Widget titleDailyQuote(String title) {
    return Container(
      margin: EdgeInsets.only(
          left: Dimentions.widthMargin20,
          top: Dimentions.heightMargin20,
          right: Dimentions.widthMargin20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.headline4,
          ),
          indicatorView(imgList)
        ],
      ),
    );
  }

  Widget titleViewAll(String title) {
    return Container(
      margin: EdgeInsets.only(
          left: Dimentions.widthMargin20,
          top: Dimentions.heightMargin10,
          right: Dimentions.widthMargin20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.headline4,
          ),
          Row(
            children: [
              Text(
                'View All',
                style: Theme.of(context).textTheme.headline5,
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: CustomColors.IconColor,
                size: 15.w,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget announcementWidget(String text, bool isGV) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimentions.widthMargin20),
      child: FractionalTranslation(
        translation: Offset(0.0, -0.5),
        child: Align(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: isGV
                      ? BorderRadius.circular(10.r)
                      : BorderRadius.circular(30.r),
                  color: CustomColors.ColorWhite,
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
                    left: Dimentions.widthMargin20,
                    right: Dimentions.widthMargin20,
                    top: Dimentions.widthMargin10,
                    bottom: Dimentions.widthMargin10),
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
            alignment: isGV ? Alignment.topCenter : Alignment.topLeft),
      ),
    );
  }
}
