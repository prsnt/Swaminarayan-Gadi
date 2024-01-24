import 'package:appstructure/data/network/apis/api_services.dart';
import 'package:appstructure/models/ghanshyam_vijay_model.dart';
import 'package:flutter/material.dart';

class GhanshyamVijayFilterNotifier with ChangeNotifier {
  GhanshyamVijayModel? ghanshyamVijayModel;
  bool isLoading = false;
  bool isLoadMoreItem = false;

  List<GhanshyamVijayData> _ghanShyamVijayFilterList = <GhanshyamVijayData>[];

  List<GhanshyamVijayData> get ghanShyamVijayFilterList => _ghanShyamVijayFilterList;

  set ghanShyamVijayFilterData(List<GhanshyamVijayModel> value) {
    _ghanShyamVijayFilterList = value.cast<GhanshyamVijayData>();
  }

  Future<void> fetchGhanShyamVijayFilterData(String year, bool isLoadMore) async {
    if (isLoadMore) {
      isLoadMoreItem = true;
      notifyListeners();
    } else {
      isLoading = true;
      notifyListeners();
    }
    await getGhanshyamVijayFilterData(year).then((value) {
      if (_ghanShyamVijayFilterList.isNotEmpty) {
        _ghanShyamVijayFilterList.clear();
      }
      addGhanShyamVijayToFilterList(value!.mainData!.data);
    });
    if (isLoadMore) {
      isLoadMoreItem = false;
    } else {
      isLoading = false;
    }
    notifyListeners();
  }

  void addGhanShyamVijayToFilterList(List<GhanshyamVijayData>? ghanShyamVijayList) {
    _ghanShyamVijayFilterList.addAll(ghanShyamVijayList!);
    notifyListeners();
  }
}
