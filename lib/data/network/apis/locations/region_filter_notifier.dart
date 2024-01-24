import 'package:appstructure/data/network/apis/api_services.dart';
import 'package:appstructure/models/region_filter_model.dart';
import 'package:flutter/material.dart';

class RegionFilterNotifier with ChangeNotifier {
  RegionFilterModel? regionFilterModel;
  bool loading = false;

  Future<void> fetchRegionFilterData() async {
    loading = true;
    regionFilterModel = (await getRegionData())!;
    loading = false;

    notifyListeners();
  }
}
