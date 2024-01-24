import 'package:appstructure/data/network/apis/api_services.dart';
import 'package:appstructure/models/news_list_category_model.dart';
import 'package:flutter/material.dart';

class NewsListCategoryNotifier with ChangeNotifier {
  NewsListCategoryModel? newsListCategoryModel;
  bool loading = false;

  Future<void> fetchNewsListCategoryData() async {
    loading = true;
    newsListCategoryModel = (await getNewsListCategoryData())!;
    loading = false;

    notifyListeners();
  }
}
