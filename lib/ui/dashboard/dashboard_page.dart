import 'package:appstructure/ui/News/newslist.dart';
import 'package:appstructure/ui/dashboard/dashboard_controller.dart';
import 'package:appstructure/ui/home/home.dart';
import 'package:appstructure/ui/more/more.dart';
import 'package:appstructure/utils/widgets_dir.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(child: IndexedStack(
            index: controller.tabIndex,
            children: const [
              Home(),
              NewsListing(),
              More(),
              NewsListing(),
              More(),
            ],
          )),
          bottomNavigationBar: WidgetsDir().bottomNavigationBar(controller),
          //floatingActionButton: WidgetsDir().floatingActionButton,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          extendBody: true,
        );
      },
    );
  }
}
