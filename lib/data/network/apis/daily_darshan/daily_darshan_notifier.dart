import 'package:appstructure/data/network/apis/api_services.dart';
import 'package:appstructure/models/daily_darshan_model.dart';
import 'package:flutter/material.dart';

class DailyDarshanNotifier with ChangeNotifier {
  DailyDarshanModel? dailyDarshanModel;
  DailyDarshanModel? dailyDarshanManinagarModel;
  DailyDarshanModel? dailyDarshanKadiMandirModel;
  List<LiveJson>? liveJsonList = [];
  bool loading = false;

  Future<void> fetchDailyDarshanData() async {
    loading = true;

    dailyDarshanModel = (await getDailyDarshanData())!;
    loading = false;
    notifyListeners();
  }

  Future<void> fetchDailyDarshanManinagarData() async {
    loading = true;
    dailyDarshanManinagarModel = (await getDailyDarshanManinagarData())!;
    loading = false;
    notifyListeners();
  }

  Future<void> fetchAllDailyDarshanData() async {
    loading = true;
    liveJsonList!.clear();
    for (int i = 0; i < dailyDarshanModel!.data![0].liveJson!.length; i++) {
      // ignore: prefer_final_locals
      LiveJson liveJson = dailyDarshanModel!.data![0].liveJson![i];
      liveJsonList!.add(liveJson);
    }
    loading = false;
    notifyListeners();
  }

  Future<void> fetchDailyDarshanKadiMandirData() async {
    loading = true;
    notifyListeners();
    dailyDarshanKadiMandirModel = (await getDailyDarshanKadiMandirData())!;
    loading = false;
    notifyListeners();
  }
}
