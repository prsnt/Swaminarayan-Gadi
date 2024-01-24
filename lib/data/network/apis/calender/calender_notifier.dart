import 'dart:convert';

import 'package:appstructure/data/network/apis/api_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalenderNotifier with ChangeNotifier {
  String? response;
  bool loading = false;
  String? content = '';

  Future<void> fetchCalenderData() async {
    loading = true;
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');
    // ignore: prefer_final_locals
    String formattedDate = formatter.format(now);
    response = (await getCalenderData(formattedDate))!;
    final item = json.decode(response!);

    content = item['data']['calender'][0]['indianDate'].toString();
    loading = false;

    notifyListeners();
  }
}
