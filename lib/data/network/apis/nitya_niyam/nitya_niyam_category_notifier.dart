import 'package:appstructure/data/network/apis/api_services.dart';
import 'package:appstructure/models/nitya_niyam_category_model.dart';
import 'package:flutter/material.dart';

class NityaNiyamCategoryNotifier with ChangeNotifier {
  NityaNiyamCategoryModel? nityaNiyamCategoryModel;
  bool loading = false;

  Future<void> fetchNityaNiyamCategoryData() async {
    loading = true;
    nityaNiyamCategoryModel = (await getNityaNiyamCategoryData())!;
    loading = false;

    notifyListeners();
  }
}
