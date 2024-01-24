import 'package:appstructure/data/network/apis/api_services.dart';
import 'package:appstructure/models/nitya_niyam_model.dart';
import 'package:flutter/material.dart';

class NityaNiyamNotifier with ChangeNotifier {
  NityaNiyamModel? nityaNiyamModel;
  bool loading = false;

  Future<void> fetchNityaNiyamData(String id) async {
    loading = true;
    nityaNiyamModel = (await getNityaNiyamData(id))!;
    loading = false;

    notifyListeners();
  }
}
