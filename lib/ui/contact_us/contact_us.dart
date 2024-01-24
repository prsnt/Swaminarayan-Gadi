import 'dart:async';

import 'package:appstructure/data/network/apis/contact_us/contact_us_notifier.dart';
import 'package:appstructure/models/contact_us_model.dart';
import 'package:appstructure/ui/widgets/appbar.dart';
import 'package:appstructure/utils/dimentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../provider/theme_provider.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(22.996358854281564, 72.61075245780286),
    zoom: 14.4746,
  );

  final List<Marker> _markers = <Marker>[];

  @override
  void initState() {
    super.initState();
    _markers.add(const Marker(
        markerId: MarkerId('SomeId'),
        position: LatLng(22.996358854281564, 72.61075245780286),
        infoWindow: InfoWindow(title: 'Shree Swaminarayan Mandir Maninagar')));
  }

  Future<ContactUsModel?> getContactUsData() async {
    final data = Provider.of<ContactUsNotifier>(context, listen: false);
    await data.fetchContactUsData();
    return data.contactUsModel;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBarCustom(
                title: 'contact_us'.tr,
                isBack: true,
                isFilter: false,
                isSearch: false,
                backCallback: () {
                  Navigator.of(context).pop(true);
                },
                filterCallBack: () {},
                searchCallBack: () {},
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: FutureBuilder<ContactUsModel?>(
                      future: getContactUsData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Container(
                            margin: EdgeInsets.only(left: Dimentions.widthMargin20, right: Dimentions.widthMargin20),
                            child: Column(
                              children: [
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      height: 200.h,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20.r),
                                          topRight: Radius.circular(20.r),
                                          bottomRight: Radius.circular(20.r),
                                          bottomLeft: Radius.circular(20.r),
                                        ),
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          heightFactor: 0.3,
                                          widthFactor: 2.5,
                                          child: GoogleMap(
                                            mapType: MapType.normal,
                                            buildingsEnabled: true,
                                            indoorViewEnabled: true,
                                            zoomControlsEnabled: false,
                                            zoomGesturesEnabled: false,
                                            initialCameraPosition: _kGooglePlex,
                                            markers: Set<Marker>.of(_markers),
                                            onMapCreated: (GoogleMapController controller) {
                                              _controller.complete(controller);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        top: 0,
                                        left: 0,
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: <Color>[Colors.black.withOpacity(0.0), Colors.black.withOpacity(0.3)],
                                              ),
                                              borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                                        )),
                                    Positioned(
                                        top: 170,
                                        right: 20,
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {},
                                              child: Image.asset(height: 30.h, width: 30.w, 'assets/images/near_me.png'),
                                            ),
                                            SizedBox(
                                              width: 20.w,
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Image.asset(
                                                'assets/images/share.png',
                                                height: 25.h,
                                                width: 25.w,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20.w,
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Image.asset(height: 30.h, width: 30.w, 'assets/images/zoom_in.png'),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      'assets/images/location_pin.png',
                                      fit: BoxFit.fill,
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Flexible(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'head_office'.tr,
                                            style: Theme.of(context).textTheme.titleLarge!.apply(
                                                color:
                                                    themeProvider.isDarkMode ? const Color(0xFFFFFFFF).withOpacity(0.40) : const Color(0xFF373A40)),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Text(
                                            '${snapshot.data!.data![0].footerContactLocation}',
                                            style: Theme.of(context).textTheme.titleLarge!.apply(
                                                fontSizeDelta: 2.0,
                                                color:
                                                    themeProvider.isDarkMode ? const Color(0xFFFFFFFF).withOpacity(0.90) : const Color(0xFF13161D)),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      'assets/images/phone.png',
                                      fit: BoxFit.fill,
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'phone'.tr,
                                          style: Theme.of(context).textTheme.titleLarge!.apply(
                                              color: themeProvider.isDarkMode ? const Color(0xFFFFFFFF).withOpacity(0.40) : const Color(0xFF373A40)),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            makePhoneCall(snapshot.data!.data![0].footerContactNumber.toString());
                                          },
                                          child: Text(
                                            '${snapshot.data!.data![0].footerContactNumber}',
                                            style: Theme.of(context).textTheme.titleLarge!.apply(
                                                fontSizeDelta: 2.0,
                                                color:
                                                    themeProvider.isDarkMode ? const Color(0xFFFFFFFF).withOpacity(0.90) : const Color(0xFF13161D)),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            makePhoneCall(snapshot.data!.data![0].footerContactNumber2.toString());
                                          },
                                          child: Text(
                                            '${snapshot.data!.data![0].footerContactNumber2}',
                                            style: Theme.of(context).textTheme.titleLarge!.apply(
                                                fontSizeDelta: 2.0,
                                                color:
                                                    themeProvider.isDarkMode ? const Color(0xFFFFFFFF).withOpacity(0.90) : const Color(0xFF13161D)),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      'assets/images/email.png',
                                      fit: BoxFit.fill,
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'email'.tr,
                                          style: Theme.of(context).textTheme.titleLarge!.apply(
                                              color: themeProvider.isDarkMode ? const Color(0xFFFFFFFF).withOpacity(0.40) : const Color(0xFF373A40)),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            launchEmail(snapshot.data!.data![0].footerContactEmail);
                                          },
                                          child: Text(
                                            '${snapshot.data!.data![0].footerContactEmail}',
                                            style: Theme.of(context).textTheme.titleLarge!.apply(
                                                fontSizeDelta: 2.0,
                                                color:
                                                    themeProvider.isDarkMode ? const Color(0xFFFFFFFF).withOpacity(0.90) : const Color(0xFF13161D)),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      'assets/images/website.png',
                                      fit: BoxFit.fill,
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'website'.tr,
                                          style: Theme.of(context).textTheme.titleLarge!.apply(
                                              color: themeProvider.isDarkMode ? const Color(0xFFFFFFFF).withOpacity(0.40) : const Color(0xFF373A40)),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            launchWebsiteUrl('https://swaminarayangadi.com/');
                                          },
                                          child: Text(
                                            'SwaminarayanGadi.com',
                                            style: Theme.of(context).textTheme.titleLarge!.apply(
                                                fontSizeDelta: 2.0,
                                                color:
                                                    themeProvider.isDarkMode ? const Color(0xFFFFFFFF).withOpacity(0.90) : const Color(0xFF13161D)),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 50.h,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          launchWebsiteUrl('https://www.facebook.com/SGadiManinagar/');
                                        },
                                        child: Image.asset('assets/images/facebook.png'),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          launchWebsiteUrl('https://twitter.com/SGadiManinagar?t=syDvYnCoJ4Wz4nGQnW7eiA&s=09');
                                        },
                                        child: Image.asset('assets/images/twitter.png'),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          launchWebsiteUrl('https://t.me/SGadiManinagar');
                                        },
                                        child: Image.asset('assets/images/telegram.png'),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          launchWebsiteUrl('https://youtube.com/c/SwaminarayanGadi');
                                        },
                                        child: Image.asset('assets/images/youtube.png'),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          launchWebsiteUrl('https://instagram.com/sgadimaninagar?igshid=YmMyMTA2M2Y=');
                                        },
                                        child: Image.asset('assets/images/instagram.png'),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 50.h,
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const Align(alignment: Alignment.topCenter, child: CircularProgressIndicator());
                        }
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> launchWebsiteUrl(String? url) async {
    Uri? uri;
    if (url!.isNotEmpty) {
      if (url.contains('https://')) {
        uri = Uri.parse(url);
      } else {
        uri = Uri.parse('https://$url');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid website url')));
    }
    if (!await launchUrl(uri!)) {
      throw 'Could not launch $uri';
    } else {
      debugPrint('Launch $uri');
    }
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> launchEmail(String? email) async {
    if (email!.isNotEmpty) {
      final Uri emailLaunchUri = Uri(scheme: 'mailto', path: email);
      if (!await launchUrl(emailLaunchUri)) {
        throw 'Could not launch $emailLaunchUri';
      } else {
        debugPrint('Launch $emailLaunchUri');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid email address')));
    }
  }

  Future<void> shareLocation(double lat, double lng) async {
    await FlutterShare.share(title: 'Share Here', text: '', linkUrl: 'https://www.google.com/maps/search/?api=1&query=$lat,$lng');
  }

  Future<void> nearMe(double lat, double lng) async {
    // ignore: prefer_final_locals
    Uri uri = Uri.parse('https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=driving&dir_action=navigate');

    if (await launchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}
