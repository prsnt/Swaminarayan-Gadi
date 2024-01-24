import 'package:appstructure/data/network/apis/api_services.dart';
import 'package:appstructure/models/news_image_gallary_model.dart';
import 'package:flutter/material.dart';

class NewsDetailImageGallaryNotifier with ChangeNotifier {
  NewsImageGallaryModel? newsImageGallaryModel;
  List<NewsGallaryImageJson>? newsGallaryImageJsonList;
  bool loading = false;
  int size = 18;

  Future<void> fetchNewsDetailImageGallaryData(String imageGallaryIds) async {
    size = 18;
    newsGallaryImageJsonList?.clear();
    loading = true;
    newsImageGallaryModel = (await getNewsDetailImageGallaryData(imageGallaryIds))!;
    newsGallaryImageJsonList = newsImageGallaryModel!.newsImageGallaryData![0].newsGallaryImageJson;
    if (newsGallaryImageJsonList!.length <= 18) {
      size = newsGallaryImageJsonList!.length;
    }
    loading = false;
    notifyListeners();
  }

  void loadMoreGallaryImage() {
    // ignore: prefer_final_locals
    int difference = newsGallaryImageJsonList!.length - size;
    if (difference >= 18) {
      size += 18;
    } else {
      size += difference;
    }
    notifyListeners();
  }
}
