import 'dart:async';

import 'package:appstructure/constants/assets.dart';
import 'package:appstructure/constants/colors.dart';
import 'package:appstructure/routes.dart';
import 'package:flutter/material.dart';
import 'package:appstructure/utils/dimentions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  late AnimationController _animationController;
  late Animation<double> _animation;

  Future<Timer> startTime() async {
    const _duration = Duration(seconds: 3);
    return Timer(_duration, navigationPage);
  }

  Future<void> navigationPage() async {
    Navigator.of(context).pushReplacementNamed(Routes.tabScreen);
  }

  @override
  void dispose() {
    super.dispose();
    _animation.removeListener(() {});
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut);

    _animation.addListener(() => setState(() {}));
    _animationController.forward();

    //startTime();

    setState(() {
      _visible = !_visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
                        child: Image.asset('assets/images/logo.png')),
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
                  'Version 1.5',
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
              )),
        ],
      ),
    );
  }
}
