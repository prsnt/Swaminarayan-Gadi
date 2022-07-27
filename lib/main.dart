import 'package:appstructure/routes/app_pages.dart';
import 'package:appstructure/ui/News/newslist.dart';
import 'package:appstructure/ui/daily_darshan/daily_darshan.dart';
import 'package:appstructure/ui/daily_quotes/daily_quotes.dart';
import 'package:appstructure/ui/home/home.dart';
import 'package:appstructure/ui/more/more.dart';
import 'package:appstructure/ui/splash/splash.dart';
import 'package:appstructure/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'bloc/employee_cubit.dart';
import 'constants/colors.dart';
import 'data/network/apis/employees/employee_api.dart';
import 'data/network/constants/api_constants.dart';
import 'data/sharedpref/constants/preferences.dart';
import 'data/sharedpref/shared_preference_helper.dart';
import 'locale/app_localisations.dart';
import 'repository/employee_repository.dart';
import 'routes/routes.dart';
import 'utils/app_bottom_navigation.dart';

Future<void> main() async {
  await ScreenUtil.ensureScreenSize();
  WidgetsFlutterBinding.ensureInitialized();
  setupLocators();
//  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
//  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runApp(MyApp());
}

void setupLocators() {
  final getIt = GetIt.instance;
  getIt.registerSingleton<WSKeys>(WSKeys.staging());
  getIt.registerSingleton<EmployeeRepository>(
      EmployeeRepository(employeeApi: EmployeeApi()));
}

class MyApp extends StatelessWidget {
  Locale locale = const Locale('en');
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(427, 760),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        return GetMaterialApp(
          title: 'Swaminarayan Gadi',
          debugShowCheckedModeBanner: false,
          locale: locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
            Locale('hi', ''), // Hindi, no country code
          ],
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            application.saveDeviceLocale(deviceLocale!);
            for (final supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == deviceLocale.languageCode) {
                if (supportedLocale.countryCode != null &&
                    supportedLocale.countryCode!.isNotEmpty) {
                  if (supportedLocale.countryCode == deviceLocale.countryCode) {
                    return supportedLocale;
                  }
                } else {
                  return supportedLocale;
                }
              }
            }
            return supportedLocales.first;
          },
          initialRoute: Routes.newslist,
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            fontFamily: 'Outfit',
            textTheme: TextTheme(
              headline1: TextStyle(fontSize: 36.sp, fontWeight: FontWeight.bold,color: Color(0xFF9E9A89)),
              headline2: TextStyle(fontSize: 24.sp, fontStyle: FontStyle.italic,color: Color(0xFF9E9A89)),
              headline4: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold,color: Color(0xFF9E9A89)),
              headline5: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600,color: Color(0xFF9E9A89)),
              bodyText2: TextStyle(fontSize: 16.sp, color: Color(0xFF9E9A89)),
              bodyText1: TextStyle(fontSize: 18.sp, color: Color(0xFF9E9A89)),
              button: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500,color: Color(0xFF0D0D0D)),
            ),
            iconTheme: const IconThemeData(
              color: Colors.white54,
            ),
            scaffoldBackgroundColor: const Color(0xFF0D0D0D),
            primarySwatch: AppColors.themeColor,
          ),
          theme: ThemeData(
            fontFamily: 'Outfit',
            textTheme: TextTheme(
              headline1: TextStyle(fontSize: 36.sp, fontWeight: FontWeight.bold,color: Color(0xFF373A40)),
              headline2: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500,color: Color(0xFF373A40)),
              headline4: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold,color: Color(0xFF373A40)),
              headline5: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600,color: Color(0xFF373A40)),
              bodyText2: TextStyle(fontSize: 16.sp, color: Color(0xFF373A40)),
              bodyText1: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500,color: Color(0xFF373A40)),
              caption: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500,color: Color(0xFF373A40)),
              button: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400,color: Color(0xFF373A40)),
            ),
            scaffoldBackgroundColor: const Color(0xFFFFFAF4),
            brightness: Brightness.light,
            primarySwatch: AppColors.themeColor,
          ),
          getPages: AppPages.list,
        );
      },
      child: const More(),
    );
  }
  // This widget is the root of your application.
  /*@override
  _MyAppState createState() => _MyAppState();*/
}


class PreferenceKeys {}
