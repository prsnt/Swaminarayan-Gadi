import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:appstructure/ui/News/news_detail.dart';
import 'package:appstructure/ui/ghan_shyam_vijay/ghan_shyam_vijay.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'bottombar/bottom_footer_navigation.dart';

class NotificationServices {
  FirebaseMessaging message = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initLocalNotifications(BuildContext context, RemoteMessage message) async {
    const androidInitilizationSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    const iosInitilizationSettings = DarwinInitializationSettings();

    const initilizationSettings = InitializationSettings(
      android: androidInitilizationSettings,
      iOS: iosInitilizationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initilizationSettings, onDidReceiveNotificationResponse: (payload) {
      handleMessage(context, message);
    }).then((value) {
      // if (Platform.isAndroid) {
      //   showNotification(message);
      // }
      showNotification(message);
    });
  }

  Future<void> requestNotificationPermission() async {
    // ignore: prefer_final_locals
    NotificationSettings settings = await message.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      sound: true,
      provisional: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User Grant Permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      debugPrint('User Grant Provisional Permission');
    } else {
      debugPrint('User Denied Permission');
      AppSettings.openNotificationSettings();
    }
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        debugPrint('Title: ${message.notification!.title.toString()}');
        debugPrint('Body: ${message.notification!.body.toString()}');
        debugPrint('Data: ${message.data.toString()}');
      }
      // if (Platform.isAndroid) {
      //   initLocalNotifications(context, message);
      //   showNotification(message);
      // } else {
      //   initLocalNotifications(context, message);
      //   showNotification(message);
      // }

      initLocalNotifications(context, message);
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'default',
      'High Importance Notification',
      importance: Importance.max,
    );

    // ignore: prefer_final_locals
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'your channel description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails();

    // ignore: prefer_final_locals
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    Future.delayed(Duration.zero, () {
      flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });
  }

  Future<String> getDeviceToken() async {
    final String? token = await message.getToken();
    return token ?? '';
  }

  void isTokenRefresh() {
    message.onTokenRefresh.listen((event) {});
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    switch (message.data['type']) {
      case 'Gvijay':
        Future.delayed(const Duration(seconds: 1), () {
          try {
            Get.offAll(const BottomFooterNavigation());
            Get.to(
                () => const GhanShyamVijay(
                      isFromNotification: true,
                    ),
                preventDuplicates: false);
          } catch (e) {
            showToastMessage(e.toString());
          }
        });
        break;
      case 'News':
        Future.delayed(const Duration(seconds: 1), () {
          try {
            Get.offAll(const BottomFooterNavigation());
            Get.to(
              () => NewsDetail(
                id: message.data['id'].toString(),
                title: message.data['title'].toString(),
                date: message.data['date'].toString(),
                image: message.data['imageUrl'].toString(),
              ),
              preventDuplicates: false,
            );
          } catch (e) {
            showToastMessage(e.toString());
          }
        });
        break;
      case 'Live':
        _launchUrl(message.data['url'].toString());
        break;
      case 'Katha':
        FlutterWebBrowser.openWebPage(
          url: message.data['url'].toString(),
          customTabsOptions: const CustomTabsOptions(
            colorScheme: CustomTabsColorScheme.system,
            shareState: CustomTabsShareState.on,
            instantAppsEnabled: true,
            showTitle: true,
            urlBarHidingEnabled: true,
          ),
          safariVCOptions: const SafariViewControllerOptions(
            barCollapsingEnabled: true,
            dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
            modalPresentationCapturesStatusBarAppearance: true,
          ),
        );
        break;
      default:
    }
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> setupInteractMessage(BuildContext context) async {
    if (Platform.isAndroid) {
      // ignore: prefer_final_locals
      Stream<RemoteMessage> _stream = FirebaseMessaging.onMessageOpenedApp;
      _stream.listen((RemoteMessage event) async {
        handleMessage(context, event);
      });
    } else if (Platform.isIOS) {
      // ignore: prefer_final_locals
      Stream<RemoteMessage> _stream = FirebaseMessaging.onMessageOpenedApp;
      _stream.listen((RemoteMessage event) async {
        handleMessage(context, event);
      });
      FirebaseMessaging.instance.getInitialMessage().then((value) {
        if (value != null) {
          handleMessage(context, value);
        }
      });
    }
  }

  Future forgroundMessage() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
  }

  void showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }
}
