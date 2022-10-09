
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:tmtt/src/network/retrofit_service.dart';

import '../constants/URLs.dart';


class RetrofitManager {

  final logger = Logger();

  static RetrofitService get retrofitService => _client();

  static var timeout = 25000; // 25 sec

  String get baseUrl => "";

  static RetrofitService _client() {
    final dio = Dio();

    dio.options.baseUrl = kDebugMode ? MyUrl.baseUrl/*dev*/ : MyUrl.baseUrl/*product*/;
    dio.options.headers = {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
    };
    dio.options.connectTimeout = timeout;
    dio.options.receiveTimeout = timeout;
    dio.options.sendTimeout = timeout;

    // dio.interceptors.clear();
    dio.interceptors.addAll([
      JsonPlaceHolderInterceptor()
    ]);

    return RetrofitService(dio);
  }
}

class JsonPlaceHolderInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('JsonPlaceHolderInterceptor: url: ${options.baseUrl}');
    print('JsonPlaceHolderInterceptor: REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('JsonPlaceHolderInterceptor: RESPONSE[${response.statusCode}] <= PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('JsonPlaceHolderInterceptor: ERROR[${err.response?.statusCode}] MESSAGE: ${err.message} $err => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}

