import 'dart:io';

import 'package:appstructure/provider/theme_provider.dart';
import 'package:appstructure/ui/about_us/about_us.dart';
import 'package:appstructure/ui/contact_us/contact_us.dart';
import 'package:appstructure/ui/location/locations.dart';
import 'package:appstructure/ui/privacy_policy/privacy_policy.dart';
import 'package:appstructure/ui/terms_and_conditions/terms_and_conditions.dart';
import 'package:appstructure/utils/custom_colors.dart';
import 'package:appstructure/utils/dimentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

class More extends StatefulWidget {
  const More({Key? key}) : super(key: key);

  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );
  int themeValue = 0;
  int languageValue = 0;

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
    _initLocale();
  }

  Future<void> _initLocale() async {
    await GetStorage.init();
    final box = GetStorage();
    if (box.read('locale') == 'en') {
      setState(() {
        languageValue = 0;
      });
    } else if (box.read('locale') == 'hi') {
      setState(() {
        languageValue = 1;
      });
    } else if (box.read('locale') == 'gu') {
      setState(() {
        languageValue = 2;
      });
    } else {
      setState(() {
        languageValue = 0;
      });
    }
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
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: Dimentions.widthMargin05, right: Dimentions.widthMargin10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              moreOption('assets/images/about_us.png', 'about_us'.tr),
              moreOption('assets/images/call.png', 'contact_us'.tr),
              moreOption('assets/images/terms_condition.png', 'terms_and_services'.tr),
              moreOption('assets/images/privacy_policy.png', 'privacy_policy'.tr),
              Container(
                margin: EdgeInsets.only(
                  left: Dimentions.widthMargin10,
                  top: Dimentions.heightMargin35,
                ),
                child: Text(
                  'settings'.tr,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/themes.png',
                          height: Dimentions.widthMargin30,
                          width: Dimentions.widthMargin30,
                          color: Theme.of(context).iconTheme.color,
                          fit: BoxFit.fill,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'theme'.tr,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ],
                    ),
                  ),
                  _offsetThemePopup()
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/translate.png',
                          height: Dimentions.widthMargin30,
                          width: Dimentions.widthMargin30,
                          color: Theme.of(context).iconTheme.color,
                          fit: BoxFit.fill,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'language'.tr,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ],
                    ),
                  ),
                  _offsetLanguagePopup()
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          Platform.isAndroid ? 'assets/images/version.png' : 'assets/images/apple_logo.png',
                          height: Dimentions.widthMargin30,
                          width: Dimentions.widthMargin30,
                          color: Theme.of(context).iconTheme.color,
                          fit: BoxFit.fill,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: Dimentions.widthMargin15),
                          child: Text(
                            'version'.tr,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      _packageInfo.version,
                      style: Theme.of(context).textTheme.displayMedium,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _offsetThemePopup() {
    return Consumer<ThemeProvider>(
      builder: (context, theme, _) {
        return PopupMenuButton<int>(
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              child: Text(
                'Light',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            PopupMenuItem(
              value: 0,
              child: Text(
                'Dark',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ],
          child: Row(
            children: [
              Container(
                child: theme.themeCode == 'Dark'
                    ? Text(
                        'Dark',
                        style: Theme.of(context).textTheme.displayMedium,
                      )
                    : Text(
                        'Light',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
              ),
              Icon(
                Icons.chevron_right,
                color: Theme.of(context).iconTheme.color,
              ),
            ],
          ),
          offset: const Offset(0, 0),
          onSelected: (value) {
            theme.toggleTheme(value);
            Get.back();
            Get.changeThemeMode(theme.themeMode);
          },
        );
      },
    );
  }

  Widget _offsetLanguagePopup() => PopupMenuButton<int>(
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 0,
            child: Text(
              'english'.tr,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          PopupMenuItem(
            value: 1,
            child: Text(
              'hindi'.tr,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          PopupMenuItem(
            value: 2,
            child: Text(
              'gujarati'.tr,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ],
        child: Row(
          children: [
            Container(
              child: languageValue == 0
                  ? Text(
                      'english'.tr,
                      style: Theme.of(context).textTheme.displayMedium,
                    )
                  : languageValue == 1
                      ? Text(
                          'hindi'.tr,
                          style: Theme.of(context).textTheme.displayMedium,
                        )
                      : Text(
                          'gujarati'.tr,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
            ),
            Icon(
              Icons.chevron_right,
              color: Theme.of(context).iconTheme.color,
            ),
          ],
        ),
        offset: const Offset(0, 0),
        onSelected: (value) {
          setState(() {
            languageValue = value;
          });
          if (languageValue == 0) {
            final box = GetStorage();
            box.write('locale', 'en');
            Get.back();
            Get.updateLocale(const Locale('en', ''));
          } else if (languageValue == 1) {
            final box = GetStorage();
            box.write('locale', 'hi');
            Get.back();
            Get.updateLocale(const Locale('hi', ''));
          } else if (languageValue == 2) {
            final box = GetStorage();
            box.write('locale', 'gu');
            Get.back();
            Get.updateLocale(const Locale('gu', ''));
          }
        },
      );

  Widget widgetDropdown(String name, String selectedString, String imgUrl) {
    return Padding(
      padding: EdgeInsets.only(left: Dimentions.widthMargin10, top: Dimentions.heightMargin25, right: Dimentions.widthMargin15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                imgUrl,
                height: Dimentions.widthMargin20,
                width: Dimentions.widthMargin20,
                color: Theme.of(context).iconTheme.color,
                fit: BoxFit.fill,
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimentions.widthMargin15),
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                selectedString,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimentions.widthMargin10),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: CustomColors.IconColor,
                  size: Dimentions.widthMargin15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget moreOption(String imageUrl, String title) {
    return GestureDetector(
      onTap: () {
        if (title == 'about_us'.tr) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AboutUs(),
            ),
          );
        } else if (title == 'contact_us'.tr) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ContactUs(),
            ),
          );
        } else if (title == 'locations'.tr) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Locations(),
            ),
          );
        } else if (title == 'privacy_policy'.tr) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PrivacyPolicy(),
            ),
          );
        } else if (title == 'terms_and_services'.tr) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TermsAndConditions(),
            ),
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.only(left: Dimentions.widthMargin10, top: Dimentions.widthMargin25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              imageUrl,
              height: Dimentions.widthMargin30,
              width: Dimentions.widthMargin30,
              color: Theme.of(context).iconTheme.color,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: EdgeInsets.only(left: Dimentions.widthMargin15),
              child: Text(
                title,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            )
          ],
        ),
      ),
    );
  }
}
