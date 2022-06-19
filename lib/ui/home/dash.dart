import 'package:appstructure/utils/dimentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF4),
      body: SafeArea(
        child: Column(
          children: [
            ConstrainedBox(
              constraints:
                  BoxConstraints(minWidth: double.infinity, maxHeight: 250.h),
              child: Container(
                  height: 250.h,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(50.r)),
                    child: Image.asset(
                      'assets/images/banner_dashboard.jpg',
                      fit: BoxFit.cover,
                    ),
                  )),
            ),
            announcementWidget('Today is Ekadasi'),
            titleViewAll('Live Broadcast')
          ],
        ),
      ),
    );
  }

  Widget titleViewAll(String title) {
    return Container(
      margin: EdgeInsets.only(left: Dimentions.widthMargin20, top: Dimentions.heightMargin20, right: Dimentions.widthMargin20),
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
                color: Color(0xFF373A40),
                size: 14.0,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget announcementWidget(String text) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimentions.widthMargin20),
      child: FractionalTranslation(
        translation: Offset(0.0, -0.5),
        child: Align(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF13161D).withOpacity(.04),
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: Offset(0, Dimentions.widthMargin05),
                    )
                  ]),
              child: Padding(
                padding: EdgeInsets.only(
                    left: Dimentions.widthMargin20, right: Dimentions.widthMargin20, top: Dimentions.widthMargin10, bottom: Dimentions.widthMargin10),
                child: Text(text),
              ),
            ),
            alignment: Alignment.topLeft),
      ),
    );
  }
}
