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

    //get expected
  @GET(AppEndPoints.incentives)
  Future<dynamic> getIncentives();

  //get dashboard
  @GET(AppEndPoints.dashboard)
  Future<dynamic> getDashboard();

  //get monitors
  @GET(AppEndPoints.getMonitors)
  Future<dynamic> getMonitors(@Query('activity') String activity);

  //apply
  @POST(AppEndPoints.apply)
  Future<dynamic> apply({@Body() required Map<String, dynamic> body});

  //appraise
  @POST(AppEndPoints.appraise)
  Future<dynamic> appraise({@Body() required Map<String, dynamic> body});

  //create monitor
  @POST(AppEndPoints.createMonitor)
  Future<dynamic> createMonitor({@Body() required Map<String, dynamic> body});

  //add comment
  @POST(AppEndPoints.addComment)
  Future<dynamic> addComment({@Body() required Map<String, dynamic> body});

  //show all comments that belong to a customer
  @GET(AppEndPoints.showAllComments)
  Future<dynamic> showAllComments(@Query('customer_id') String customerId);

  //get all comments
  @GET(AppEndPoints.getAllComments)
  Future<dynamic> getAllComments();
}
