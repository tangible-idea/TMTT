import 'package:retrofit/retrofit.dart';

import 'package:dio/dio.dart';
import 'package:tmtt/data/model/hutils.dart';


part 'retrofit_service.g.dart';

@RestApi()
abstract class RetrofitService {

  factory RetrofitService(Dio dio) = _RetrofitService;

  @GET("whois")
  Future<HUtils> getWhoisInfo();

}

