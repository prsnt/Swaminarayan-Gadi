import 'package:appstructure/data/network/apis/api_services.dart';
import 'package:appstructure/models/daily_darshan_model.dart';
import 'package:flutter/material.dart';

class LiveDarshanNotifier with ChangeNotifier {
  DailyDarshanModel? dailyDarshanModel;
  DailyDarshanModel? dailyDarshanManinagarModel;
  bool loading = false;
  int selectedIndex = -1;
  int scrollIndex = 0;
  List<LiveJson> liveJsonList = [];

  Future<void> fetchLiveDarshanData() async {
    dailyDarshanModel = (await getDailyDarshanData())!;
  }

  Future<void> fetchLiveDarshanManinagarData() async {
    dailyDarshanManinagarModel = (await getDailyDarshanManinagarData())!;
  }

  Future<void> fetchAllLiveData() async {
    loading = true;
    notifyListeners();
    await fetchLiveDarshanData();
    await fetchLiveDarshanManinagarData();
    for (int i = 0; i < dailyDarshanModel!.data![0].liveJson!.length; i++) {
      liveJsonList.add(dailyDarshanModel!.data![0].liveJson![i]);
    }
    loading = false;
    notifyListeners();
  }

  void updateIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void updateScrollIndex(int index) {
    scrollIndex = index;
    notifyListeners();
  }
}
