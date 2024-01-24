import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:appstructure/data/network/apis/api_services.dart';
import 'package:appstructure/notification_services.dart';
import 'package:appstructure/utils/app_constant.dart';
import 'package:appstructure/utils/dimentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

import '../../bottombar/bottom_footer_navigation.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  NotificationServices notificationServices = NotificationServices();

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );
  late String platformVersion, imeiNo = '', modelName = '', manufacturer = '', deviceName = '', productName = '', cpuType = '', hardware = '';
  var apiLevel;

  Future<Timer> startTime() async {
    const _duration = Duration(seconds: 3);
    return Timer(_duration, userToken);
  }

  Future<void> userToken() async {
    notificationServices.requestNotificationPermission();
    //notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    Map<String, String> requestBody;

    final udid = await FlutterUdid.udid;
    final String firebaseToken = await notificationServices.getDeviceToken();
    requestBody = {
      'deviceKey': udid,
      'androidKey': udid,
      'mModel': '',
      'mBrand': '',
      'mManufacturer': '',
      'mProduct': '',
      'mAndroid': '',
      'mAPILevel': '1.1',
      'mVersionRelease': '',
      'DeviceType': Platform.isAndroid ? 'Android' : 'IOS',
      'PushTokan': firebaseToken,
      'login_by': '',
      'displayOrder': '0',
      'status': 'active'
    };

    final box = GetStorage();
    box.write('FirebaseToken', firebaseToken);
    userTokenApiCall(requestBody);
  }

  Future<void> userTokenApiCall(Map<String, String> requestBody) async {
    try {
      print('Request Body: $requestBody');
      const url = '${AppConstants.BASE_URL}/user-token';
      final response = await http.post(
        Uri.parse(url),
        headers: {HttpHeaders.contentTypeHeader: 'application/json', 'accept': '*/*', 'x-access-token': AppConstants.Token},
        body: jsonEncode(requestBody),
      );
      if (response.statusCode == 201) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const BottomFooterNavigation()),
          (route) => false,
        );
      }
    } catch (e) {
      showToastMessage(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
    startTime();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background_splash.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: Dimentions.heightMargin70),
                child: Column(
                  children: [
                    FractionallySizedBox(
                      widthFactor: 0.4,
                      child: Image.asset('assets/images/logo.png'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Dimentions.heightMargin25),
                      child: Image.asset('assets/images/app_name.png'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Image.asset('assets/images/maninagar_temple.png'),
            alignment: Alignment.bottomCenter,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: Dimentions.heightMargin25),
              child: Text(
                'Version ${_packageInfo.version}',
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
