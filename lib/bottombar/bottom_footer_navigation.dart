import 'dart:io';

import 'package:appstructure/bottombar/bottom_bar.dart';
import 'package:appstructure/ui/more/more.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../ui/News/newslist.dart';
import '../ui/home/home.dart';
import '../ui/location/locations.dart';
import '../ui/nitya_niyams/nitya_niyams_list.dart';
import '../utils/custom_colors.dart';

enum BottomTab { locations, news, home, niyam, more }

class BottomNavPage {
  BottomNavPage(
    this.label,
    this.widget,
    this.icon,
    this.tab,
  );
  final String label;
  final Widget widget;
  final String icon;
  final BottomTab tab;
}

class BottomFooterNavigation extends StatefulWidget {
  const BottomFooterNavigation({Key? key, this.selectedIndex = 2}) : super(key: key);
  final int selectedIndex;

  @override
  _BottomFooterNavigationState createState() => _BottomFooterNavigationState();
}

class _BottomFooterNavigationState extends State<BottomFooterNavigation> with WidgetsBindingObserver {
  BottomTab _selectedTab = BottomTab.home;

  final List<BottomNavPage> _pages = [
    BottomNavPage('locations'.tr, const Locations(), 'assets/images/place.png', BottomTab.locations),
    BottomNavPage('news'.tr, const NewsListing(), 'assets/images/news.png', BottomTab.news),
    BottomNavPage('Home', const Home(), 'assets/images/home_icon.png', BottomTab.home),
    BottomNavPage('niyam'.tr, const NityaNiyamList(), 'assets/images/bottom_nityam.png', BottomTab.niyam),
    BottomNavPage('more'.tr, const More(), 'assets/images/more.png', BottomTab.more),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  void _onItemTapped(BottomTab tab) {
    setState(() {
      _selectedTab = tab;
    });
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: _pages.firstWhere((element) => element.tab == _selectedTab).widget,
      // bottomNavigationBar: BottomBar(
      //   onBottomTabSelected: (tab) {
      //     _onItemTapped(tab.index);
      //   },
      // ),

      bottomNavigationBar: SafeArea(
        // ignore: avoid_bool_literals_in_conditional_expressions
        bottom: Platform.isIOS ? false : true,
        child: Container(
          height: kToolbarHeight + 16.h,
          color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _pages.map(
              (data) {
                if (data.tab == BottomTab.home) {
                  return SizedBox(
                    width: 50.w,
                    height: 50.h,
                  );
                }
                return GestureDetector(
                  onTap: () {
                    _onItemTapped(data.tab);
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageIcon(
                        AssetImage(data.icon),
                        color: data.tab == _selectedTab ? CustomColors.OrangeColor : const Color(0xFF777777),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Text(
                        data.label,
                        style: data.tab == _selectedTab
                            ? Theme.of(context).bottomNavigationBarTheme.selectedLabelStyle!.copyWith(color: CustomColors.OrangeColor)
                            : Theme.of(context).bottomNavigationBarTheme.selectedLabelStyle,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                    ],
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          _onItemTapped(BottomTab.home);
        },
        // child: Image.asset(
        //   'assets/images/home_icon.png',
        //   height: 150.h,
        //   width: 150.w,
        //   fit: BoxFit.cover,
        // ),

        child: Container(
          padding: EdgeInsets.all(18.h),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                blurRadius: 80,
                color: Color(0xFFFF624F),
                spreadRadius: 1,
              )
            ],
            gradient: LinearGradient(
              colors: [
                Color(0xFFFF624F),
                Color(0xFFFF2E3A),
              ],
              begin: Alignment.center,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Image.asset(
            'assets/images/home.png',
            height: 25.w,
            width: 25.w,
            //fit: BoxFit.cover,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
