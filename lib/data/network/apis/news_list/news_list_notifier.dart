import 'package:appstructure/data/network/apis/api_services.dart';
import 'package:appstructure/models/news_list_model.dart';
import 'package:flutter/material.dart';

class NewsListNotifier with ChangeNotifier {
  NewsListModel? newsListModel;
  bool loading = false;

  Future<void> fetchNewsListData() async {
    loading = true;
    notifyListeners();
    newsListModel = (await getNewsListHomeData())!;
    loading = false;
    notifyListeners();
  }

  int _page = 1;
  int get page => _page;

  set page(int value) {
    _page = value;
    notifyListeners();
  }

  List<NewsData> _newsList = <NewsData>[];

  List<NewsData> get newsList => _newsList;

  set locationData(List<NewsListModel> value) {
    _newsList = value.cast<NewsData>();
  }

  Future<void> fetchNewsData(String newsCategoryId, String newsSelectedYear, String search) async {
    loading = true;

    await getNewsListData(_page, newsCategoryId, newsSelectedYear, search).then((value) {
      _page = _page + 1;
      addNewsToList(value!.mainData!.data);
    });
    loading = false;

    notifyListeners();
  }

  Future<void> fetchNewsFilterData(String newsCategoryId, String newsSelectedYear, bool isFilterApply, String search) async {
    loading = true;
    _page = 1;
    _newsList.clear();
    await getNewsListData(_page, newsCategoryId, newsSelectedYear, search).then((value) {
      addNewsToList(value!.mainData!.data);
    });
    loading = false;

    notifyListeners();
  }

  Future<void> fetchNewsSearchData(String newsCategoryId, String newsSelectedYear, String search) async {
    loading = true;
    _page = 1;
    _newsList.clear();
    await getNewsListData(_page, newsCategoryId, newsSelectedYear, search).then((value) {
      addNewsToList(value!.mainData!.data);
    });
    loading = false;

    notifyListeners();
  }

  void addNewsToList(List<NewsData>? newsList) {
    _newsList.addAll(newsList!);
    notifyListeners();
  }
}
