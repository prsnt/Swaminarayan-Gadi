import 'package:flutter/cupertino.dart';
import 'package:appstructure/utils/dimentions.dart';

class WidgetsDir{

  Container backBtn()
  {
    return Container(
      margin: EdgeInsets.only(top: Dimentions.heightMargin10),
      child: Image.asset('assets/images/back_btn.png',height: Dimentions.widthMargin45,
        width: Dimentions.widthMargin45,
        fit: BoxFit.fill),
    );
  }
}