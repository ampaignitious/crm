import 'package:dio/dio.dart';
import 'package:aiDvantage/Util/AppEndPoints.dart';
import 'package:retrofit/retrofit.dart';


part 'endpoint.g.dart';

@RestApi(baseUrl: AppEndPoints.baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST(AppEndPoints.loginEndPoint)
  Future<dynamic> signIn({@Body() required Map<String, String> body});

  @POST(AppEndPoints.logoutEndPoint)
  Future<dynamic> signOut();
}

