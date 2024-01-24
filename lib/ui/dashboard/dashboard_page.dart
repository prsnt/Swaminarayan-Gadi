import 'dart:io';

import 'package:appstructure/ui/News/newslist.dart';
import 'package:appstructure/ui/dashboard/dashboard_controller.dart';
import 'package:appstructure/ui/home/home.dart';
import 'package:appstructure/ui/location/locations.dart';
import 'package:appstructure/ui/more/more.dart';
import 'package:appstructure/ui/nitya_niyams/nitya_niyams_list.dart';
import 'package:appstructure/utils/app_constant.dart';
import 'package:appstructure/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// class DashboardPage extends StatelessWidget {
//   const DashboardPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<DashboardController>(
//       builder: (controller) {
//         return Scaffold(
//           resizeToAvoidBottomInset: false,
//           body: SafeArea(
//               child: IndexedStack(
//             index: controller.tabIndex,
//             children: const [
//               Locations(),
//               NewsListing(),
//               Home(),
//               NityaNiyamList(),
//               More(),
//             ],
//           )),
//           bottomNavigationBar: Container(
//             height: Platform.isAndroid ? 75.h : 100.h,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(topRight: Radius.circular(15.r), topLeft: Radius.circular(15.r)),
//               boxShadow: [
//                 BoxShadow(color: Colors.black38.withOpacity(0.15), spreadRadius: 0, blurRadius: 10),
//               ],
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(15.r),
//                 topRight: Radius.circular(15.r),
//               ),
//               child: BottomNavigationBar(
//                 onTap: (index) {
//                   if (index != 2) {
//                     AppConstants.isMirgrationDialogShow = false;
//                   }
//                   controller.changeTabIndex(index);
//                 },
//                 currentIndex: controller.tabIndex,
//                 elevation: 10,
//                 selectedItemColor: CustomColors.OrangeColor,
//                 selectedLabelStyle: Theme.of(context).bottomNavigationBarTheme.selectedLabelStyle,
//                 unselectedLabelStyle: Theme.of(context).bottomNavigationBarTheme.unselectedLabelStyle,
//                 backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
//                 type: BottomNavigationBarType.fixed,
//                 items: <BottomNavigationBarItem>[
//                   BottomNavigationBarItem(
//                       icon: const Padding(
//                         padding: EdgeInsets.all(5.0),
//                         child: ImageIcon(
//                           AssetImage('assets/images/place.png'),
//                         ),
//                       ),
//                       label: 'locations'.tr),
//                   BottomNavigationBarItem(
//                       icon: const Padding(
//                         padding: EdgeInsets.all(5.0),
//                         child: ImageIcon(
//                           AssetImage('assets/images/news.png'),
//                         ),
//                       ),
//                       label: 'news'.tr),
//                   const BottomNavigationBarItem(
//                       icon: SizedBox(
//                         width: 0,
//                         height: 0,
//                       ),
//                       label: ''),
//                   BottomNavigationBarItem(
//                       icon: const Padding(
//                         padding: EdgeInsets.all(5.0),
//                         child: ImageIcon(
//                           AssetImage('assets/images/bottom_nityam.png'),
//                         ),
//                       ),
//                       label: 'niyam'.tr),
//                   BottomNavigationBarItem(
//                       icon: const Padding(
//                         padding: EdgeInsets.all(5.0),
//                         child: ImageIcon(
//                           AssetImage('assets/images/more.png'),
//                         ),
//                       ),
//                       label: 'more'.tr),
//                 ],
//                 showUnselectedLabels: true,
//               ),
//             ),
//           ),
//           floatingActionButton: GestureDetector(
//             onTap: () {
//               controller.changeTabIndex(2);
//             },
//             child: Image.asset(
//               'assets/images/home_icon.png',
//               height: 150.h,
//               width: 150.w,
//               fit: BoxFit.cover,
//             ),
//           ),
//           floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
//           extendBody: true,
//         );
//       },
//     );
//   }
// }

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
              child: IndexedStack(
            index: controller.tabIndex,
            children: const [
              Locations(),
              NewsListing(),
              Home(),
              NityaNiyamList(),
              More(),
            ],
          )),
          bottomNavigationBar: Container(
            height: Platform.isAndroid ? 75.h : 100.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(15.r), topLeft: Radius.circular(15.r)),
              boxShadow: [
                BoxShadow(color: Colors.black38.withOpacity(0.15), spreadRadius: 0, blurRadius: 10),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.r),
                topRight: Radius.circular(15.r),
              ),
              child: BottomNavigationBar(
                onTap: (index) {
                  if (index != 2) {
                    AppConstants.isMirgrationDialogShow = false;
                  }
                  controller.changeTabIndex(index);
                },
                currentIndex: controller.tabIndex,
                elevation: 10,
                selectedItemColor: CustomColors.OrangeColor,
                selectedLabelStyle: Theme.of(context).bottomNavigationBarTheme.selectedLabelStyle,
                unselectedLabelStyle: Theme.of(context).bottomNavigationBarTheme.unselectedLabelStyle,
                backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                type: BottomNavigationBarType.fixed,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: ImageIcon(
                          AssetImage('assets/images/place.png'),
                        ),
                      ),
                      label: 'locations'.tr),
                  BottomNavigationBarItem(
                      icon: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: ImageIcon(
                          AssetImage('assets/images/news.png'),
                        ),
                      ),
                      label: 'news'.tr),
                  const BottomNavigationBarItem(
                      icon: SizedBox(
                        width: 0,
                        height: 0,
                      ),
                      label: ''),
                  BottomNavigationBarItem(
                      icon: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: ImageIcon(
                          AssetImage('assets/images/bottom_nityam.png'),
                        ),
                      ),
                      label: 'niyam'.tr),
                  BottomNavigationBarItem(
                      icon: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: ImageIcon(
                          AssetImage('assets/images/more.png'),
                        ),
                      ),
                      label: 'more'.tr),
                ],
                showUnselectedLabels: true,
              ),
            ),
          ),
          floatingActionButton: GestureDetector(
            onTap: () {
              controller.changeTabIndex(2);
            },
            child: Image.asset(
              'assets/images/home_icon.png',
              height: 150.h,
              width: 150.w,
              fit: BoxFit.cover,
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
          extendBody: true,
        );
      },
    );
  }
}
