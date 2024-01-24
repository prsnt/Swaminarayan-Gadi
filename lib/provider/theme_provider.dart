import 'package:appstructure/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  String themeCode = '';

  bool get isDarkMode {
    final box = GetStorage();
    if (box.read('Theme') == 'Dark') {
      return true;
    } else {
      return false;
    }
  }

  Future<String> fetchTheme() async {
    final box = GetStorage();
    if (box.read('Theme') == 'Dark') {
      themeCode = 'Dark';
    } else {
      themeCode = 'Light';
    }
    return themeCode;
  }

  Future<void> toggleTheme(int isOn) async {
    final box = GetStorage();
    if (isOn == 0) {
      themeMode = isOn == 0 ? ThemeMode.dark : ThemeMode.light;
      box.write('Theme', 'Dark');
      notifyListeners();
    } else {
      themeMode = isOn == 0 ? ThemeMode.dark : ThemeMode.light;
      box.write('Theme', 'Light');
      notifyListeners();
    }
  }
}

// ignore: avoid_classes_with_only_static_members
class MyThemes {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Outfit',
    textTheme: TextTheme(
      displayLarge: TextStyle(fontFamily: 'Outfit', fontSize: 36.sp, color: const Color(0xFFFFFFFF)),
      displayMedium: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500, fontFamily: 'Outfit', color: const Color(0xFFFFFFFF)),
      displaySmall: TextStyle(fontSize: 16.sp, fontFamily: 'Outfit', fontWeight: FontWeight.w700, color: const Color(0xFFFFFFFF)),
      headlineMedium: TextStyle(fontSize: 14.sp, fontFamily: 'Outfit', fontWeight: FontWeight.w500, color: const Color(0xFFFFFFFF)),
      headlineSmall: TextStyle(fontSize: 12.sp, fontFamily: 'Outfit', fontWeight: FontWeight.w400, color: const Color(0xFFFFFFFF)),
      titleLarge: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500, fontFamily: 'Outfit', color: const Color(0xFFFFFFFF)),
      bodyLarge: TextStyle(fontSize: 14.sp, fontFamily: 'Outfit', fontWeight: FontWeight.w500, color: const Color(0xFFFFFFFF)),
      bodyMedium: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, fontFamily: 'Outfit', color: const Color(0xFFFFFFFF)),
      labelLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: const Color(0xFF0D0D0D)),
    ),
    iconTheme: const IconThemeData(
      color: Color(0xFFFFFFFF),
    ),
    scaffoldBackgroundColor: const Color(0xFF0D0D0D).withOpacity(0.70),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color(0xFF262829),
      elevation: 10,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(color: const Color(0xFF777777), fontFamily: 'Outfit', fontSize: 14.sp, fontWeight: FontWeight.w500),
      unselectedLabelStyle: TextStyle(color: const Color(0xFF777777), fontFamily: 'Outfit', fontSize: 14.sp, fontWeight: FontWeight.w500),
      selectedItemColor: const Color(0xFF777777),
      unselectedItemColor: const Color(0xFF777777),
      showUnselectedLabels: true,
    ),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Color(0xFF0D0D0D)),
    // colorScheme: ColorScheme.fromSwatch(primarySwatch: AppColors.themeColor).copyWith(
    //   secondary: const Color(0xFF262829),
    // ),
    colorScheme:
        ColorScheme.fromSwatch(primarySwatch: AppColors.themeColor).copyWith(secondary: const Color(0xFF262829), brightness: Brightness.dark),
  );

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Outfit',
    textTheme: TextTheme(
      displayLarge: TextStyle(fontFamily: 'Outfit', fontSize: 36.sp, color: const Color(0xFF13161D)),
      displayMedium: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500, fontFamily: 'Outfit', color: const Color(0xFF13161D)),
      displaySmall: TextStyle(fontSize: 16.sp, fontFamily: 'Outfit', fontWeight: FontWeight.w700, color: const Color(0xFF13161D)),
      headlineMedium: TextStyle(fontSize: 14.sp, fontFamily: 'Outfit', fontWeight: FontWeight.w500, color: const Color(0xFF13161D)),
      headlineSmall: TextStyle(fontSize: 12.sp, fontFamily: 'Outfit', fontWeight: FontWeight.w400, color: const Color(0xFF13161D)),
      titleLarge: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500, fontFamily: 'Outfit', color: const Color(0xFF13161D)),
      bodyLarge: TextStyle(fontSize: 14.sp, fontFamily: 'Outfit', fontWeight: FontWeight.w500, color: const Color(0xFF13161D)),
      bodyMedium: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, fontFamily: 'Outfit', color: const Color(0xFF13161D)),
      labelLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: const Color(0xFF13161D)),
    ),
    iconTheme: const IconThemeData(
      color: Color(0xFF13161D),
    ),
    scaffoldBackgroundColor: const Color(0xFFFFFAF4),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(color: const Color(0xFF777777), fontFamily: 'Outfit', fontSize: 14.sp, fontWeight: FontWeight.w500),
        unselectedLabelStyle: TextStyle(color: const Color(0xFF777777), fontFamily: 'Outfit', fontSize: 14.sp, fontWeight: FontWeight.w500),
        selectedItemColor: const Color(0xFF777777),
        unselectedItemColor: const Color(0xFF777777),
        showUnselectedLabels: true),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Color(0xFFFFFFFF)),
    // colorScheme: ColorScheme.fromSwatch(primarySwatch: AppColors.themeColor).copyWith(
    //   secondary: const Color(0xFFFFFFFF),
    // ),
    colorScheme:
        ColorScheme.fromSwatch(primarySwatch: AppColors.themeColor).copyWith(secondary: const Color(0xFFFFFFFF), brightness: Brightness.light),
  );
}
