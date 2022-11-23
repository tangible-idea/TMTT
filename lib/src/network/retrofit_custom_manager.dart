
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:dio/dio.dart';
import 'package:tmtt/src/constants/app_secret.dart';
import 'package:tmtt/src/network/retrofit_manager.dart';
import 'package:tmtt/src/network/retrofit_service.dart';

class RetrofitCustomManager {

  String baseURL = '';
  String authKey = '';
  RetrofitCustomManager({
    this.baseURL = '',
    this.authKey = AppSecret.FLARELANE_API_KEY
  });

  final logger = Logger();
  static var timeout = 25000; // 25 sec

  RetrofitService get retrofitService => _client();

  RetrofitService _client() {
    final dio = Dio();

    dio.options.baseUrl = baseURL;
    dio.options.headers = {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: authKey
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

