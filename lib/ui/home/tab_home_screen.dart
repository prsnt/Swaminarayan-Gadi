import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../routes.dart';
import '../../utils/app_bottom_navigation.dart';
import '../first_view.dart';
import '../fourth_view.dart';
import '../second_view.dart';
import '../third_view.dart';

// ignore: must_be_immutable
class TabHomeScreen extends StatelessWidget {
  Map<int, Color> color = {
    50: const Color.fromRGBO(250, 202, 88, .1),
    100: const Color.fromRGBO(250, 202, 88, .2),
    200: const Color.fromRGBO(250, 202, 88, .3),
    300: const Color.fromRGBO(250, 202, 88, .4),
    400: const Color.fromRGBO(250, 202, 88, .5),
    500: const Color.fromRGBO(250, 202, 88, .6),
    600: const Color.fromRGBO(250, 202, 88, .7),
    700: const Color.fromRGBO(250, 202, 88, .8),
    800: const Color.fromRGBO(250, 202, 88, .9),
    900: const Color.fromRGBO(250, 202, 88, 1),
  };

  final arrBottomItems = [
    tabItem('First View', Icons.home),
    tabItem('Second View', Icons.category),
    tabItem('Third View', Icons.favorite),
    tabItem('Fourth View', Icons.search),
  ];

  @override
  Widget build(BuildContext context) {
//    final MaterialColor colorCustom = MaterialColor(0xFFFACA58, color);
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Consumer<BottomNavigatorProvider>(
            builder: (ctx, item, child) {
              if (item.selectedIndex == 0) {
                return const Text(
                  'First View',
                  style: TextStyle(color: Colors.white),
                );
              } else if (item.selectedIndex == 1) {
                return const Text('Second View',
                    style: TextStyle(color: Colors.white));
              } else if (item.selectedIndex == 2) {
                return const Text('Third View',
                    style: TextStyle(color: Colors.white));
              } else if (item.selectedIndex == 3) {
                return const Text('Fourth View',
                    style: TextStyle(color: Colors.white));
              } else {
                return Container();
              }
            },
          ),
          brightness: Brightness.dark),
      body: Center(
        child: Consumer<BottomNavigatorProvider>(
          builder: (ctx, item, child) {
            switch (item.selectedIndex) {
              case 0:
                return FirstView();
                break;
              case 1:
                return SecondView();
                break;
              case 2:
                return ThirdView();
                break;
              case 3:
                return FourthView();
                break;
              default:
                return FirstView();
                break;
            }
          },
        ),
      ),
      bottomNavigationBar: BottomNavigation(
          arrBottomItems: arrBottomItems,
          backgroundColor: AppColors.themeColor,
          showSelectedLables: true,
          showUnselectedLables: true,
          color: Colors.black,
          selectedColor: Colors.white),
    );
  }
}
