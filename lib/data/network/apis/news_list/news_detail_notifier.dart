import 'dart:convert';

import 'package:appstructure/data/network/apis/api_services.dart';
import 'package:flutter/material.dart';

class NewsDetailNotifier with ChangeNotifier {
  List<String>? newsDetailImageList = [];
  String? response;
  bool loading = false;
  String? content = '';
  String? imageGallary = '';
  String? video = '';

  Future<void> fetchNewsDetailData(String id) async {
    loading = true;
    response = (await getNewsDetailData(id))!;
    final item = json.decode(response.toString());
    final data = item['data'] as List;
    if (data.isNotEmpty) {
      for (int i = 0; i < data.length; i++) {
        if (data[i]['type'] == 'cnt_100') {
          content = data[i]['desc'].toString();
        }

        if (data[i]['type'] == 'tModule') {
          if (data[i]['tagType'] == 'imageGallery') {
            imageGallary = data[i]['referenceLink'].toString();
          }

          if (data[i]['tagType'] == 'pVideo') {
            video = data[i]['referenceLink'].toString();
          }
        }
      }
    }
    loading = false;
    notifyListeners();
  }
}
