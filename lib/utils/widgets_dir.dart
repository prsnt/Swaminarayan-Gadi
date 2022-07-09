import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:appstructure/ui/dashboard/dashboard_controller.dart';
import 'package:appstructure/utils/custom_colors.dart';
import 'package:appstructure/utils/dimentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WidgetsDir  {
  Container backBtn() {
    return Container(
      margin: EdgeInsets.only(top: Dimentions.heightMargin10),
      child: Image.asset('assets/images/back_btn.png',
          height: Dimentions.widthMargin50,
          width: Dimentions.widthMargin50,
          fit: BoxFit.fill),
    );
  }

  Container backBtnNoMargin() {
    return Container(
      child: Image.asset('assets/images/back_btn.png',
          height: Dimentions.widthMargin50,
          width: Dimentions.widthMargin50,
          fit: BoxFit.fill),
    );
  }


  Widget bottomNavigationBar(DashboardController controller) {
    return Container(
      height: 70.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30.r), topLeft: Radius.circular(30.r)),
        boxShadow: [
          BoxShadow(
              color: Colors.black38.withOpacity(0.15),
              spreadRadius: 0,
              blurRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
        child: BottomNavigationBar(
          onTap: controller.changeTabIndex,
          currentIndex: controller.tabIndex,
          elevation: 10,
          backgroundColor: CustomColors.ColorWhite,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle:
              TextStyle(fontSize: 14.sp, color: CustomColors.OrangeColor),
          unselectedLabelStyle:
              TextStyle(fontSize: 14.sp, color: CustomColors.FontColorGray),
          selectedIconTheme: IconThemeData(color: CustomColors.OrangeColor),
          unselectedIconTheme: IconThemeData(color: CustomColors.FontColorGray),
          items: const [
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: ImageIcon(
                    AssetImage("assets/images/livedarshan.png"),
                  ),
                ),
                label: 'Live Darshan'),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: ImageIcon(
                    AssetImage("assets/images/news.png"),
                  ),
                ),
                label: 'News'),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: ImageIcon(
                    AssetImage("assets/images/nityam.png"),
                  ),
                ),
                label: 'Niyam'),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: ImageIcon(
                    AssetImage("assets/images/more.png"),
                  ),
                ),
                label: 'More'),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: ImageIcon(
                    AssetImage("assets/images/more.png"),
                  ),
                ),
                label: 'More'),
          ],
          unselectedItemColor: CustomColors.FontColorGray,
          selectedItemColor: CustomColors.ColorBlack,
          showUnselectedLabels: true,
        ),
      ),
    );
  }

  Widget get floatingActionButton {
    return Container(
        height: 65.w,
        width: 65.w,
        child: FittedBox(
          child: FloatingActionButton(
            elevation: 5,
            mini: true,
            onPressed: () {},
            child: Container(
              width: 60.w,
              height: 60.w,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [CustomColors.Gradient1, CustomColors.Gradient2],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
              child: Icon(Icons.home_outlined)
            ),
            // elevation: 5.0,
          ),
        ));
  }
}
