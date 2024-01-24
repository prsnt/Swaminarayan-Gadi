import 'dart:convert';
import 'dart:io';

import 'package:appstructure/models/about_us_model.dart';
import 'package:appstructure/models/contact_us_model.dart';
import 'package:appstructure/models/daily_darshan_model.dart';
import 'package:appstructure/models/daily_quote_model.dart';
import 'package:appstructure/models/ghanshyam_vijay_model.dart';
import 'package:appstructure/models/home_model.dart';
import 'package:appstructure/models/live_broadcast_model.dart';
import 'package:appstructure/models/location_data_model.dart';
import 'package:appstructure/models/location_filter_model.dart';
import 'package:appstructure/models/news_detail_videos_model.dart';
import 'package:appstructure/models/news_image_gallary_model.dart';
import 'package:appstructure/models/news_list_category_model.dart';
import 'package:appstructure/models/news_list_model.dart';
import 'package:appstructure/models/nitya_niyam_category_model.dart';
import 'package:appstructure/models/nitya_niyam_model.dart';
import 'package:appstructure/models/region_filter_model.dart';
import 'package:appstructure/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

Future<GhanshyamVijayModel?> getGhanshyamVijayData(int page) async {
  GhanshyamVijayModel? result;
  try {
    final url = '${AppConstants.BASE_URL}/publication/gvijay/front?sortField=publishOn&sortType=desc&page=$page&recordPerPage=12';

    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json', 'accept': '*/*', 'x-access-token': AppConstants.Token},
    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      result = GhanshyamVijayModel.fromJson(item as Map<String, dynamic>);
    } else {
      showToastMessage('Error ${response.body}');
    }
  } catch (e) {
    //log(e.toString());
    showToastMessage('Catch Error $e');
  }
  return result;
}

Future<GhanshyamVijayModel?> getGhanshyamVijayFilterData(String year) async {
  GhanshyamVijayModel? result;
  try {
    final url = '${AppConstants.BASE_URL}/publication/gvijay/front?sortField=publishOn&sortType=desc&recordPerPage=12&year=$year';
    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json', 'accept': '*/*', 'x-access-token': AppConstants.Token},
    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      result = GhanshyamVijayModel.fromJson(item as Map<String, dynamic>);
    } else {
      showToastMessage('Error ${response.body}');
    }
  } catch (e) {
    showToastMessage('Catch Error $e');
  }
  return result;
}

Future<DailyQuoteModel?> getDailyQuoteData() async {
  DailyQuoteModel? result;
  try {
    const url = '${AppConstants.BASE_URL}/quote/filter';
    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json', 'accept': '*/*', 'x-access-token': AppConstants.Token},
    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      result = DailyQuoteModel.fromJson(item as Map<String, dynamic>);
    } else {
      showToastMessage('Error ${response.body}');
    }
  } catch (e) {
    showToastMessage('Catch Error $e');
  }
  return result;
}

Future<LocationDataModel?> getLocationData(int page) async {
  LocationDataModel? result;
  try {
    final url = '${AppConstants.BASE_URL}/mandir/filter?page=$page&recordPerPage=10';
    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json', 'accept': '*/*', 'x-access-token': AppConstants.Token},
    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      result = LocationDataModel.fromJson(item as Map<String, dynamic>);
    } else {
      showToastMessage('Error ${response.body}');
    }
  } catch (e) {
    showToastMessage('Catch Error $e');
  }
  return result;
}

Future<HomeModel?> getHomeData() async {
  HomeModel? result;
  try {
    const url = '${AppConstants.BASE_URL}/cms/cms-page-content/level1/62cdb9a6c9349940e485f50b';
    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json', 'accept': '*/*', 'x-access-token': AppConstants.Token},
    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      result = HomeModel.fromJson(item as Map<String, dynamic>);
    } else {
      showToastMessage('Error ${response.body}');
    }
  } catch (e) {
    showToastMessage('Catch Error $e');
  }
  return result;
}

Future<NewsListModel?> getNewsListHomeData() async {
  NewsListModel? result;
  try {
    const url = '${AppConstants.BASE_URL}/news/front?recordPerPage=5&sortField=publishOn&sortType=desc';
    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json', 'accept': '*/*', 'x-access-token': AppConstants.Token},
    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      result = NewsListModel.fromJson(item as Map<String, dynamic>);
    } else {
      showToastMessage('Error ${response.body}');
    }
  } catch (e) {
    showToastMessage('Catch Error $e');
  }
  return result;
}

Future<AboutUsModel?> getAboutUsData() async {
  AboutUsModel? result;
  try {
    const url = '${AppConstants.BASE_URL}/cms/cms-page-content/level1/62f425a1669082d78ead093b';
    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json', 'accept': '*/*', 'x-access-token': AppConstants.Token},
    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      result = AboutUsModel.fromJson(item as Map<String, dynamic>);
    } else {
      showToastMessage('Error ${response.body}');
    }
  } catch (e) {
    showToastMessage('Catch Error $e');
  }
  return result;
}

Future<NewsListModel?> getNewsListData(int page, String newsCategoryId, String newsSelectedYear, String search) async {
  NewsListModel? result;
  try {
    final url =
        '${AppConstants.BASE_URL}/news/front?sortField=publishOn&sortType=desc&page=$page&recordPerPage=10&category=$newsCategoryId&year=$newsSelectedYear&search=$search';

    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json', 'accept': '*/*', 'x-access-token': AppConstants.Token},
    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      result = NewsListModel.fromJson(item as Map<String, dynamic>);
    } else {
      showToastMessage('Error ${response.body}');
    }
  } catch (e) {
    showToastMessage('Catch Error $e');
  }
  return result;
}

Future<ContactUsModel?> getContactUsData() async {
  ContactUsModel? result;
  try {
    const url = '${AppConstants.BASE_URL}/global/site/623beec8aeff82542fd87e55';
    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json', 'accept': '*/*', 'x-access-token': AppConstants.Token},
    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      result = ContactUsModel.fromJson(item as Map<String, dynamic>);
    } else {
      showToastMessage('Error ${response.body}');
    }
  } catch (e) {
    showToastMessage('Catch Error $e');
  }
  return result;
}

Future<RegionFilterModel?> getRegionData() async {
  RegionFilterModel? result;
  try {
    const url = '${AppConstants.BASE_URL}/mandir/region/all';
    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json', 'accept': '*/*', 'x-access-token': AppConstants.Token},
    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body);

      result = RegionFilterModel.fromJson(item as Map<String, dynamic>);
    } else {
      showToastMessage('Error ${response.body}');
    }
  } catch (e) {
    showToastMessage('Catch Error $e');
  }
  return result;
}

Future<LocationFilterModel?> getLocationFilterData(String regionId) async {
  LocationFilterModel? result;
  try {
    final url = '${AppConstants.BASE_URL}/mandir/level1/$regionId';
    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json', 'accept': '*/*', 'x-access-token': AppConstants.Token},
    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      result = LocationFilterModel.fromJson(item as Map<String, dynamic>);
    } else {
      showToastMessage('Error ${response.body}');
    }
  } catch (e) {
    showToastMessage('Catch Error $e');
  }
  return result;
}

Future<NityaNiyamCategoryModel?> getNityaNiyamCategoryData() async {
  NityaNiyamCategoryModel? result;
  try {
    const url = '${AppConstants.BASE_URL}/publication/nitya-niyam-category/all';
    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json', 'accept': '*/*', 'x-access-token': AppConstants.Token},
    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      result = NityaNiyamCategoryModel.fromJson(item as Map<String, dynamic>);
    } else {
      showToastMessage('Error ${response.body}');
    }
  } catch (e) {
    showToastMessage('Catch Error $e');
  }
  return result;
}

Future<NityaNiyamModel?> getNityaNiyamData(String id) async {
  NityaNiyamModel? result;
  try {
    final url = '${AppConstants.BASE_URL}/publication/nitya-niyam/category-wise/$id';
    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json', 'accept': '*/*', 'x-access-token': AppConstants.Token},
    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      result = NityaNiyamModel.fromJson(item as Map<String, dynamic>);
    } else {
      showToastMessage('Error ${response.body}');
    }
  } catch (e) {
    showToastMessage('Catch Error $e');
  }
  return result;
}

Future<NewsListCategoryModel?> getNewsListCategoryData() async {
  NewsListCategoryModel? result;
  try {
    const url = '${AppConstants.BASE_URL}/news/category/filter';
    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json', 'accept': '*/*', 'x-access-token': AppConstants.Token},
    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      result = NewsListCategoryModel.fromJson(item as Map<String, dynamic>);
    } else {
      showToastMessage('Error ${response.body}');
    }
  } catch (e) {
    showToastMessage('Catch Error $e');
  }
  return result;
}

Future<String?> getNewsDetailData(String id) async {
  String? result;
  try {
    final url = '${AppConstants.BASE_URL}/cms/cms-page-content/level1/$id';
    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json', 'accept': '*/*', 'x-access-token': AppConstants.Token},
    );
    if (response.statusCode == 200) {
      result = response.body;
    } else {
      showToastMessage('Error ${response.body}');
    }
  } catch (e) {
    showToastMessage('Catch Error $e');
  }
  return result;
}

Future<DailyDarshanModel?> getDailyDarshanData() async {
  DailyDarshanModel? result;
  try {
    const url = '${AppConstants.BASE_URL}/cms/cms-page-content/630da24f83ad596d36896ec7';
    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json', 'accept': '*/*', 'x-access-token': AppConstants.Token},
    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      result = DailyDarshanModel.fromJson(item as Map<String, dynamic>);
    } else {
      showToastMessage('Error ${response.body}');
    }
  } catch (e) {
    showToastMessage('Catch Error $e');
  }
  return result;
}

Future<DailyDarshanModel?> getDailyDarshanManinagarData() async {
  DailyDarshanModel? result;
  try {
    const url = '${AppConstants.BASE_URL}/cms/cms-page-content/630e126d5b04ec1b07f698d5';
    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json', 'accept': '*/*', 'x-access-token': AppConstants.Token},
    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      result = DailyDarshanModel.fromJson(item as Map<String, dynamic>);
    } else {
      showToastMessage('Error ${response.body}');
    }
  } catch (e) {
    showToastMessage('Catch Error $e');
  }
  return result;
}

Future<DailyDarshanModel?> getDailyDarshanKadiMandirData() async {
  DailyDarshanModel? result;
  try {
    const url = '${AppConstants.BASE_URL}/cms/cms-page-content/631ecea794a866af29479ada';
    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json', 'accept': '*/*', 'x-access-token': AppConstants.Token},
    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      result = DailyDarshanModel.fromJson(item as Map<String, dynamic>);
    } else {
      showToastMessage('Error ${response.body}');
    }
  } catch (e) {
    showToastMessage('Catch Error $e');
  }
  return result;
}

Future<NewsImageGallaryModel?> getNewsDetailImageGallaryData(String ids) async {
  NewsImageGallaryModel? result;
  try {
    final url = '${AppConstants.BASE_URL}/publication/image-gallery/ids/$ids';
    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json', 'accept': '*/*', 'x-access-token': AppConstants.Token},
    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      result = NewsImageGallaryModel.fromJson(item as Map<String, dynamic>);
    } else {
      showToastMessage('Error ${response.body}');
    }
  } catch (e) {
    showToastMessage('Catch Error $e');
  }
  return result;
}

Future<NewsDetailVideosModel?> getNewsDetailVideosData(String ids) async {
  NewsDetailVideosModel? result;
  try {
    final url = '${AppConstants.BASE_URL}/publication/video/ids/$ids';
    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json', 'accept': '*/*', 'x-access-token': AppConstants.Token},
    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      result = NewsDetailVideosModel.fromJson(item as Map<String, dynamic>);
    } else {
      showToastMessage('Error ${response.body}');
    }
  } catch (e) {
    showToastMessage('Catch Error $e');
  }
  return result;
}

Future<LiveBroadcastModel?> getLiveBroadCastData() async {
  LiveBroadcastModel? result;
  try {
    const url = '${AppConstants.BASE_URL}/livebroadcast/event/filter?sortField=publishOn&sortType=desc';
    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json', 'accept': '*/*', 'x-access-token': AppConstants.Token},
    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      result = LiveBroadcastModel.fromJson(item as Map<String, dynamic>);
    } else {
      showToastMessage('Error ${response.body}');
    }
  } catch (e) {
    showToastMessage('Catch Error $e');
  }
  return result;
}

Future<String?> getCalenderData(String date) async {
  String? result;
  try {
    final url = '${AppConstants.BASE_URL}/calendar/event/$date/$date';
    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json', 'accept': '*/*', 'x-access-token': AppConstants.Token},
    );
    if (response.statusCode == 200) {
      result = response.body;
    } else {
      showToastMessage('Error ${response.body}');
    }
  } catch (e) {
    showToastMessage('Catch Error $e');
  }
  return result;
}

void showToastMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0);
}
