import 'package:dio/dio.dart';
import 'package:vfu/Util/AppEndPoints.dart';
import 'package:retrofit/retrofit.dart';

part 'endpoint.g.dart';

@RestApi(baseUrl: AppEndPoints.baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST(AppEndPoints.loginEndPoint)
  Future<dynamic> signIn({@Body() required Map<String, String> body});

  @GET(AppEndPoints.profile)
  Future<dynamic> getProfile();

  @POST(AppEndPoints.registerEndPoint)
  Future<dynamic> signUp({@Body() required Map<String, String> body});

  @POST(AppEndPoints.logoutEndPoint)
  Future<dynamic> signOut();

  @POST(AppEndPoints.arrears)
  Future<dynamic> getArrears({@Body() required Map<String, String> body});

  //get sales
  @POST(AppEndPoints.sales)
  Future<dynamic> getSales({@Body() required Map<String, String> body});

  //get expected
  @POST(AppEndPoints.expected)
  Future<dynamic> getExpected({@Body() required Map<String, String> body});

  //get dashboard
  @GET(AppEndPoints.dashboard)
  Future<dynamic> getDashboard();
}
