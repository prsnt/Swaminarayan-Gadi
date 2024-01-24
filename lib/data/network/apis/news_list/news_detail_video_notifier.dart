import 'package:appstructure/data/network/apis/api_services.dart';
import 'package:appstructure/models/news_detail_videos_model.dart';
import 'package:flutter/material.dart';

class NewsDetailVideoNotifier with ChangeNotifier {
  NewsDetailVideosModel? newsDetailVideosModel;
  List<NewsDetailVideosData>? newsDetailVideosDataList;
  bool loading = false;

  Future<void> fetchNewsDetailVideoData(String videoIds) async {
    loading = true;
    newsDetailVideosModel = (await getNewsDetailVideosData(videoIds))!;
    newsDetailVideosDataList = newsDetailVideosModel!.newsDetailVideosDataList;
    loading = false;
    notifyListeners();
  }
}
