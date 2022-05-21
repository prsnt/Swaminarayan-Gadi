import 'dart:async';

import 'package:appstructure/constants/assets.dart';
import 'package:appstructure/constants/colors.dart';
import 'package:appstructure/routes.dart';
import 'package:flutter/material.dart';
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

    startTime();

    setState(() {
      _visible = !_visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
        orientation: Orientation.portrait);
    return Scaffold(
      backgroundColor: AppColors.orangeColor,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Text(
                    'Version 1.0',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                Assets.logo,
              ),
              const SizedBox(height: 50,),
              const CircularProgressIndicator(),
            ],
          ),
        ],
      ),
    );
  }
}
