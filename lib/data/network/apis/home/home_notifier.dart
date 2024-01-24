import 'package:appstructure/data/network/apis/api_services.dart';
import 'package:appstructure/models/home_model.dart';
import 'package:flutter/material.dart';

class HomeNotifier with ChangeNotifier {
  HomeModel? homeModel;
  bool loading = false;

  Future<void> fetchHomeData() async {
    loading = true;
    notifyListeners();
    homeModel = (await getHomeData())!;
    loading = false;

    notifyListeners();
  }
}
