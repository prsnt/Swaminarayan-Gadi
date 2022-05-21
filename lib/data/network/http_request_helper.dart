import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'constants/api_constants.dart';

class HttpRequestHelper {
  // Get:-----------------------------------------------------------------------
  static Future<Dio> getDio() async {
    final Dio dio = Dio();
    final keys = GetIt.instance<WSKeys>();
    dio.options.baseUrl = keys.baseUrl;
    dio.options.headers[WSParameters.accept] = 'application/json';
    dio.options.headers[WSParameters.xApiKey] = keys.apiKey;
    return dio;
  }

  static Future<Dio> fileUploadDio() async {
    final Dio dio = Dio();
    final keys = GetIt.instance<WSKeys>();
    dio.options.baseUrl = keys.baseUrl;
    dio.options.headers[WSParameters.accept] = 'application/json';
    dio.options.headers[WSParameters.contentType] = 'multipart/form-data';
    dio.options.headers[WSParameters.xApiKey] = keys.apiKey;
    return dio;
  }
}
