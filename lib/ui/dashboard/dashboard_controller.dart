import 'package:get/get.dart';

class DashboardController extends GetxController {
  var tabIndex = 2;

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }
}
