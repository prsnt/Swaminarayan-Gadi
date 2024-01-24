import 'package:appstructure/ui/dashboard/dashboard_controller.dart';
import 'package:appstructure/utils/custom_colors.dart';
import 'package:appstructure/utils/dimentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WidgetsDir {
  Container backBtn() {
    return Container(
      margin: EdgeInsets.only(top: Dimentions.heightMargin10),
      child: Image.asset(
        'assets/images/back_btn.png',
        height: Dimentions.widthMargin50,
        width: Dimentions.widthMargin50,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget backBtnNoMargin(Function callback) {
    return GestureDetector(
      onTap: () => callback,
      child: Container(
        child: Image.asset(
          'assets/images/back_btn.png',
          height: Dimentions.widthMargin75,
          width: Dimentions.widthMargin75,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget filterBtnNoMargin(Function filterCallBack) {
    return GestureDetector(
      onTap: () => filterCallBack(),
      child: Container(
        child: Image.asset(
          'assets/images/filter.png',
          height: Dimentions.widthMargin75,
          width: Dimentions.widthMargin75,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget searchBtnNoMargin(Function callback) {
    return GestureDetector(
      onTap: () => callback,
      child: Container(
        child: Image.asset(
          'assets/images/search.png',
          height: Dimentions.widthMargin75,
          width: Dimentions.widthMargin75,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget bottomNavigationBar(DashboardController controller, BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    // ignore: prefer_final_locals
    bool isDarkMode = brightness == Brightness.dark;
    return Container(
      height: 70.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30.r),
          topLeft: Radius.circular(30.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black38.withOpacity(0.15),
            spreadRadius: 0,
            blurRadius: 10,
          ),
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
          backgroundColor: isDarkMode ? const Color(0xFF262829) : const Color(0xFFFFFFFF),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF777777),
          unselectedItemColor: const Color(0xFF777777),
          items: const [
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: ImageIcon(
                    AssetImage('assets/images/livedarshan.png'),
                  ),
                ),
                label: 'Live Darshan'),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: ImageIcon(
                    AssetImage('assets/images/news.png'),
                  ),
                ),
                label: 'News'),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: ImageIcon(
                    AssetImage('assets/images/bottom_nityam.png'),
                  ),
                ),
                label: 'Niyam'),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: ImageIcon(
                    AssetImage('assets/images/more.png'),
                  ),
                ),
                label: 'More'),
          ],
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
            child: const Icon(
              Icons.home_outlined,
              color: CustomColors.ColorWhite,
            ),
          ),
        ),
      ),
    );
  }
}
