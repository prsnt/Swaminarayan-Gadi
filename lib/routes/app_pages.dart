import 'package:appstructure/routes/routes.dart';
import 'package:appstructure/ui/daily_darshan.dart';
import 'package:appstructure/ui/dashboard/dashboard_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../ui/dashboard/dashboard_binding.dart';

class AppPages {
  static var list = [
    GetPage(
      name: Routes.dashboardScreen,
      page: () => DashboardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: Routes.dailydarshan,
      page: () => DailyDarshan(),
      //binding: DashboardBinding(),
    ),
  ];
}