import 'package:appstructure/data/network/apis/api_services.dart';
import 'package:appstructure/models/daily_quote_model.dart';
import 'package:flutter/material.dart';

class DailyQuoteNotifier with ChangeNotifier {
  DailyQuoteModel? dailyQuoteModel;
  bool loading = false;

  Future<void> fetchDailyQuoteData() async {
    loading = true;
    notifyListeners();
    dailyQuoteModel = (await getDailyQuoteData())!;
    loading = false;

    notifyListeners();
  }
}
