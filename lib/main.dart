import 'dart:io';

import 'package:appstructure/data/network/apis/about_us/about_us_notifier.dart';
import 'package:appstructure/data/network/apis/calender/calender_notifier.dart';
import 'package:appstructure/data/network/apis/contact_us/contact_us_notifier.dart';
import 'package:appstructure/data/network/apis/daily_darshan/daily_darshan_notifier.dart';
import 'package:appstructure/data/network/apis/daily_quotes/daily_quote_notifier.dart';
import 'package:appstructure/data/network/apis/ghanshyam_vijay/ghanshyam_vijay_filter_notifier.dart';
import 'package:appstructure/data/network/apis/ghanshyam_vijay/ghanshyam_vijay_notifier.dart';
import 'package:appstructure/data/network/apis/home/home_notifier.dart';
import 'package:appstructure/data/network/apis/live_broadcast/live_broadcast_notifier.dart';
import 'package:appstructure/data/network/apis/live_darshan/live_darshan_notifier.dart';
import 'package:appstructure/data/network/apis/locations/location_filter_notifier.dart';
import 'package:appstructure/data/network/apis/locations/location_notifier.dart';
import 'package:appstructure/data/network/apis/locations/region_filter_notifier.dart';
import 'package:appstructure/data/network/apis/news_list/news_detail_image_gallary_notifier.dart';
import 'package:appstructure/data/network/apis/news_list/news_detail_notifier.dart';
import 'package:appstructure/data/network/apis/news_list/news_detail_video_notifier.dart';
import 'package:appstructure/data/network/apis/news_list/news_list_category_notifier.dart';
import 'package:appstructure/data/network/apis/news_list/news_list_notifier.dart';
import 'package:appstructure/data/network/apis/nitya_niyam/nitya_niyam_category_notifier.dart';
import 'package:appstructure/data/network/apis/nitya_niyam/nitya_niyam_notifier.dart';
import 'package:appstructure/data/sharedpref/constants/preferences.dart';
import 'package:appstructure/data/sharedpref/shared_preference_helper.dart';
import 'package:appstructure/locale/languages.dart';
import 'package:appstructure/provider/app_language_notifier.dart';
import 'package:appstructure/provider/download_provider.dart';
import 'package:appstructure/provider/theme_provider.dart';
import 'package:appstructure/ui/splash/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  await GetStorage.init();
  await ScreenUtil.ensureScreenSize();
  // ignore: deprecated_member_use
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        ChangeNotifierProvider<AppLanguageNotifier>(create: (_) => AppLanguageNotifier()),
        ChangeNotifierProvider<FileDownloaderProvider>(create: (_) => FileDownloaderProvider()),
        ChangeNotifierProvider<GhanshyamVijayNotifier>(create: (_) => GhanshyamVijayNotifier()),
        ChangeNotifierProvider<DailyQuoteNotifier>(create: (_) => DailyQuoteNotifier()),
        ChangeNotifierProvider<LocationNotifier>(create: (_) => LocationNotifier()),
        ChangeNotifierProvider<HomeNotifier>(create: (_) => HomeNotifier()),
        ChangeNotifierProvider<NewsListNotifier>(create: (_) => NewsListNotifier()),
        ChangeNotifierProvider<AboutUsNotifier>(create: (_) => AboutUsNotifier()),
        ChangeNotifierProvider<GhanshyamVijayFilterNotifier>(create: (_) => GhanshyamVijayFilterNotifier()),
        ChangeNotifierProvider<ContactUsNotifier>(create: (_) => ContactUsNotifier()),
        ChangeNotifierProvider<LocationFilterNotifier>(create: (_) => LocationFilterNotifier()),
        ChangeNotifierProvider<RegionFilterNotifier>(create: (_) => RegionFilterNotifier()),
        ChangeNotifierProvider<NityaNiyamCategoryNotifier>(create: (_) => NityaNiyamCategoryNotifier()),
        ChangeNotifierProvider<NityaNiyamNotifier>(create: (_) => NityaNiyamNotifier()),
        ChangeNotifierProvider<NewsListCategoryNotifier>(create: (_) => NewsListCategoryNotifier()),
        ChangeNotifierProvider<NewsDetailNotifier>(create: (_) => NewsDetailNotifier()),
        ChangeNotifierProvider<DailyDarshanNotifier>(create: (_) => DailyDarshanNotifier()),
        ChangeNotifierProvider<NewsDetailImageGallaryNotifier>(create: (_) => NewsDetailImageGallaryNotifier()),
        ChangeNotifierProvider<NewsDetailVideoNotifier>(create: (_) => NewsDetailVideoNotifier()),
        ChangeNotifierProvider<LiveBroadCastNotifier>(create: (_) => LiveBroadCastNotifier()),
        ChangeNotifierProvider<LiveDarshanNotifier>(create: (_) => LiveDarshanNotifier()),
        ChangeNotifierProvider<CalenderNotifier>(create: (_) => CalenderNotifier())
      ],
      child: const MyApp(),
    ));
  });
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale locale = const Locale('en');

  @override
  void initState() {
    super.initState();
  }

  Future<String> fetchTheme() async {
    final themeCode = await SharedPreferenceHelper().getValue(Preferences.themeCode) as String;
    return themeCode;
  }

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    String languageCode = 'en';
    String theme = '';
    if (box.read('locale') == 'en') {
      languageCode = 'en';
    } else if (box.read('locale') == 'hi') {
      languageCode = 'hi';
    } else if (box.read('locale') == 'gu') {
      languageCode = 'gu';
    } else {
      languageCode = 'en';
    }
    if (box.read('Theme') == 'Dark') {
      theme = 'Dark';
    } else {
      theme = 'Light';
    }

    return ScreenUtilInit(
      designSize: const Size(427, 760),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          enableLog: false,
          translations: Languages(),
          locale: Locale(languageCode, ''),
          fallbackLocale: const Locale('en', ''),
          themeMode: theme == 'Dark' ? ThemeMode.dark : ThemeMode.light,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          title: 'Swaminarayan Gadi',
          debugShowCheckedModeBanner: false,
          // initialRoute: Routes.splashScreen,
          // getPages: AppPages.list,

          home: SplashScreen(),
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
