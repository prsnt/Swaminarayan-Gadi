import 'package:appstructure/data/network/apis/api_services.dart';
import 'package:appstructure/models/live_broadcast_model.dart';
import 'package:flutter/material.dart';

class LiveBroadCastNotifier with ChangeNotifier {
  LiveBroadcastModel? liveBroadcastModel;
  List<LiveBroadCastData>? liveBroadCastList = [];
  bool loading = false;
  int scrollIndex = 0;

  Future<void> fetchLiveBroadCastData() async {
    loading = true;
    liveBroadcastModel = (await getLiveBroadCastData())!;
    for (int i = 0; i < liveBroadcastModel!.data!.liveBroadCastList!.length; i++) {
      if (liveBroadcastModel!.data!.liveBroadCastList![i].broadcast == 'active') {
        liveBroadCastList!.add(liveBroadcastModel!.data!.liveBroadCastList![i]);
      }
    }
    loading = false;
    notifyListeners();
  }

  void updateScrollIndex(int index) {
    scrollIndex = index;
    notifyListeners();
  }
}
