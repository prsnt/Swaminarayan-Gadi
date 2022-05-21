import 'package:flutter/material.dart';

import 'ui/home/tab_home_screen.dart';

class Routes {
  Routes._();

  static const String tabScreen = '/tabScreen';

  static final routes = <String, WidgetBuilder>{
    tabScreen: (ctx) => TabHomeScreen(),
  };
}
