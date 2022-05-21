import 'package:appstructure/ui/home/tab_home_screen.dart';
import 'package:appstructure/ui/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
import 'routes.dart';
import 'utils/app_bottom_navigation.dart';
import 'utils/app_drawer.dart';

void main() {
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

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale locale = const Locale('en');

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future refresh(Locale newLocale) async {
    locale = newLocale;
    await SharedPreferenceHelper()
        .setValue(Preferences.languageCode, newLocale.languageCode);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: DrawerNavigationProvider()),
        ChangeNotifierProvider.value(value: BottomNavigatorProvider())
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => EmployeeCubit(),
          ),
        ],
        child: MaterialApp(
          title: 'SGadi',
          debugShowCheckedModeBanner: false,
          locale: locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          supportedLocales: application.supportedLocales(),
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
          theme: ThemeData(
            primarySwatch: AppColors.themeColor,
          ),
          home: SplashScreen(),
          routes: Routes.routes,
        ),
      ),
    );
  }

  Future<void> getData() async {
    final _locale = await application.fetchLocale();
    locale = _locale!;
    if (mounted) {
      setState(() {});
    }
  }
}

class PreferenceKeys {}
