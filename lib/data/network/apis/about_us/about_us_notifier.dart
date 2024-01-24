import 'package:appstructure/data/network/apis/api_services.dart';
import 'package:appstructure/models/about_us_model.dart';
import 'package:flutter/material.dart';

class AboutUsNotifier with ChangeNotifier {
  AboutUsModel? aboutUsModel;
  bool loading = false;

  Future<void> fetchAboutUsData() async {
    loading = true;
    aboutUsModel = (await getAboutUsData())!;
    loading = false;

    notifyListeners();
  }
}
