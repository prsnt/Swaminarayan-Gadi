import 'package:appstructure/routes/routes.dart';
import 'package:appstructure/ui/News/newslist.dart';
import 'package:appstructure/ui/about_us/about_us.dart';
import 'package:appstructure/ui/contact_us/contact_us.dart';
import 'package:appstructure/ui/contact_us/map_full_screen.dart';
import 'package:appstructure/ui/daily_quotes/daily_quotes.dart';
import 'package:appstructure/ui/dashboard/dashboard_page.dart';
import 'package:appstructure/ui/ghan_shyam_vijay/ghan_shyam_vijay.dart';
import 'package:appstructure/ui/live_darshan/live_darshan.dart';
import 'package:appstructure/ui/location/locations.dart';
import 'package:appstructure/ui/nitya_niyams/nitya_niyams_list.dart';
import 'package:appstructure/ui/privacy_policy/privacy_policy.dart';
import 'package:appstructure/ui/splash/splash.dart';
import 'package:appstructure/ui/terms_and_conditions/terms_and_conditions.dart';
import 'package:appstructure/ui/under_construction/under_construction.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../bottombar/bottom_footer_navigation.dart';
import '../ui/dashboard/dashboard_binding.dart';
import '../ui/home/home.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static var list = [
    GetPage(
      name: Routes.splashScreen,
      page: () => SplashScreen(),
    ),
    // GetPage(
    //   name: Routes.dashboardScreen,
    //   page: () => const DashboardPage(),
    //   binding: DashboardBinding(),
    // ),
    GetPage(
      name: Routes.dashboardScreen,
      page: () => const BottomFooterNavigation(),
      //binding: DashboardBinding(),
    ),
    GetPage(
      name: Routes.livedarshan,
      page: () => const LiveDarshan(),
    ),
    GetPage(
      name: Routes.newslist,
      page: () => const NewsListing(),
    ),
    GetPage(
      name: Routes.ghanshyamvijay,
      page: () => const GhanShyamVijay(
        isFromNotification: false,
      ),
    ),
    GetPage(
      name: Routes.aboutus,
      page: () => const AboutUs(),
    ),
    GetPage(
      name: Routes.contactus,
      page: () => const ContactUs(),
    ),
    GetPage(
      name: Routes.locations,
      page: () => const Locations(),
    ),
    GetPage(
      name: Routes.dailyQuotes,
      page: () => const DailyQuotes(),
    ),
    GetPage(
      name: Routes.nityaniyamslits,
      page: () => const NityaNiyamList(),
    ),
    GetPage(
      name: Routes.privacypolicy,
      page: () => const PrivacyPolicy(),
    ),
    GetPage(
      name: Routes.termsandconditions,
      page: () => const TermsAndConditions(),
    ),
    GetPage(
      name: Routes.underconstruction,
      page: () => const UnderConstruction(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const Home(),
    ),
    GetPage(
      name: Routes.mapfullscreen,
      page: () => const MapFullScreen(),
    )
  ];
}
