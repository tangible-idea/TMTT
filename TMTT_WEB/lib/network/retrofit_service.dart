import 'package:retrofit/retrofit.dart';

import 'package:dio/dio.dart';

import '../data/hutils.dart';
import '../data/instagram.dart';

part 'retrofit_service.g.dart';

@RestApi()
abstract class RetrofitService {

  factory RetrofitService(Dio dio) = _RetrofitService;

  @GET("whois")
  Future<HUtils> getWhoisInfo();

  @GET("?__a=1&__d=dis")
  Future<Instagram> getInstagramInfo();

  @GET("sendpush")
  Future<String> sendPush(@Body() Map<String, dynamic> body);

  @POST("notifications")
  Future<String> notifications(
    @Header("Authorization") header,
    @Body() Map<String, dynamic> body
  );

}

