import 'package:appstructure/data/network/apis/api_services.dart';
import 'package:appstructure/models/ghanshyam_vijay_model.dart';
import 'package:flutter/material.dart';

class GhanshyamVijayNotifier with ChangeNotifier {
  GhanshyamVijayModel? ghanshyamVijayModel;
  int _page = 1;
  int get page => _page;
  bool isLoading = false;
  bool isHomeLoading = true;
  bool isLoadMoreItem = false;

  set page(int value) {
    _page = value;
    notifyListeners();
  }

  List<GhanshyamVijayData> _ghanShyamVijayList = <GhanshyamVijayData>[];

  List<GhanshyamVijayData> get ghanShyamVijayList => _ghanShyamVijayList;

  set ghanShyamVijayData(List<GhanshyamVijayModel> value) {
    _ghanShyamVijayList = value.cast<GhanshyamVijayData>();
  }

  Future<void> fetchGhanShyamVijayData(bool isLoadMore) async {
    if (isLoadMore) {
      isLoadMoreItem = true;
      notifyListeners();
    } else {
      isLoading = true;
      notifyListeners();
    }
    await getGhanshyamVijayData(_page).then((value) {
      _page = _page + 1;
      addGhanShyamVijayToList(value!.mainData!.data);
    });

    if (isLoadMore) {
      isLoadMoreItem = false;
    } else {
      isLoading = false;
    }
    notifyListeners();
  }

  Future<void> fetchGhanShyamVijayHomeData() async {
    isHomeLoading = true;
    notifyListeners();
    ghanshyamVijayModel = (await getGhanshyamVijayData(1))!;
    isHomeLoading = false;
    notifyListeners();
  }

  void addGhanShyamVijayToList(List<GhanshyamVijayData>? ghanShyamVijayList) {
    _ghanShyamVijayList.addAll(ghanShyamVijayList!);
    notifyListeners();
  }
}
