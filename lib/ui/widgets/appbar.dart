import 'package:appstructure/utils/dimentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/widgets_dir.dart';

class AppBarCustom extends StatelessWidget {
  Function callback;
  final String? title;
  final bool? isNews;

  AppBarCustom({Key? key,this.title,this.isNews,required this.callback}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimentions.widthMargin05,vertical: Dimentions.heightMargin10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              WidgetsDir().backBtnNoMargin(() => callback),
              Padding(
                padding: EdgeInsets.only(left: Dimentions.widthMargin10),
                child: Text(title!, style: Theme.of(context).textTheme.headline4),
              )
            ],
          ),
          Row(
            children: [
              if (isNews!) WidgetsDir().backBtnNoMargin(() => callback) else Container(),
              if (isNews!) WidgetsDir().backBtnNoMargin(() => callback) else Container(),
            ],
          ),
        ],
      ),
    );
  }
}
