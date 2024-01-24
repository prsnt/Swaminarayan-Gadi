import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../utils/custom_colors.dart';

enum BottomTab { locations, news, home, niyam, more }

typedef OnBottomTabSeleted = Function(BottomTab);

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key, required this.onBottomTabSelected}) : super(key: key);
  final OnBottomTabSeleted onBottomTabSelected;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  BottomTab activeTab = BottomTab.home;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // ignore: avoid_bool_literals_in_conditional_expressions
      bottom: Platform.isIOS ? false : true,
      child: Container(
        height: kToolbarHeight + 16.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BottomBarItem(
              activeTab: activeTab,
              tab: BottomTab.locations,
              title: 'locations'.tr,
              icon: 'assets/images/place.png',
              onTap: () {
                onTabClick(BottomTab.locations);
              },
            ),
            BottomBarItem(
              activeTab: activeTab,
              tab: BottomTab.news,
              title: 'news'.tr,
              icon: 'assets/images/news.png',
              onTap: () {
                onTabClick(BottomTab.news);
              },
            ),
            BottomBarItem(
              activeTab: activeTab,
              tab: BottomTab.home,
              title: 'home'.tr,
              icon: 'assets/images/home_icon.png',
              onTap: () {
                onTabClick(BottomTab.home);
              },
            ),
            BottomBarItem(
              activeTab: activeTab,
              tab: BottomTab.niyam,
              title: 'niyam'.tr,
              icon: 'assets/images/bottom_nityam.png',
              onTap: () {
                onTabClick(BottomTab.niyam);
              },
            ),
            BottomBarItem(
              activeTab: activeTab,
              tab: BottomTab.more,
              title: 'more'.tr,
              icon: 'assets/images/more.png',
              onTap: () {
                onTabClick(BottomTab.more);
              },
            ),
          ],
        ),
      ),
    );
  }

  void onTabClick(BottomTab tab) {
    widget.onBottomTabSelected(tab);
    setState(() {
      activeTab = tab;
    });
  }
}

class BottomBarItem extends StatelessWidget {
  const BottomBarItem({Key? key, required this.activeTab, required this.tab, required this.title, required this.icon, required this.onTap})
      : super(key: key);
  final BottomTab activeTab;
  final BottomTab tab;
  final String title;
  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (tab == BottomTab.home) {
      return SizedBox(
        width: 50.w,
        height: 50.h,
      );

      // return Align(
      //   alignment: const Alignment(0.0, -4.5),
      //   child: GestureDetector(
      //     onTap: onTap,
      //     child: Container(
      //       padding: EdgeInsets.all(18.h),
      //       decoration: const BoxDecoration(
      //         shape: BoxShape.circle,
      //         boxShadow: [
      //           BoxShadow(
      //             blurRadius: 80,
      //             color: Color(0xFFFF624F),
      //             spreadRadius: 1,
      //           )
      //         ],
      //         gradient: LinearGradient(
      //           colors: [
      //             Color(0xFFFF624F),
      //             Color(0xFFFF2E3A),
      //           ],
      //           begin: Alignment.center,
      //           end: Alignment.bottomCenter,
      //         ),
      //       ),
      //       child: Image.asset(
      //         'assets/images/home.png',
      //         height: 20.w,
      //         width: 20.w,
      //       ),
      //     ),
      //   ),
      // );
    } else {
      return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.translucent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageIcon(
              AssetImage(icon),
              color: tab == activeTab ? CustomColors.OrangeColor : const Color(0xFF777777),
            ),
            SizedBox(
              height: 3.h,
            ),
            Text(
              title,
              style: tab == activeTab
                  ? Theme.of(context).bottomNavigationBarTheme.selectedLabelStyle!.copyWith(color: CustomColors.OrangeColor)
                  : Theme.of(context).bottomNavigationBarTheme.selectedLabelStyle,
            ),
            SizedBox(
              height: 2.h,
            ),
          ],
        ),
      );
    }
  }
}
