import 'dart:async';
import 'package:dio/dio.dart';

import '../../../network/constants/endpoints.dart';
import '../../../network/http_request_helper.dart';

class EmployeeApi {
  /// sample api call with default rest client
  Future<Response> getEmployees() async {
    final Dio dio = await HttpRequestHelper.getDio();
    final Response response = await dio.get(Endpoints.getEmployees);
    return response;
  }
}
