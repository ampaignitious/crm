import 'package:dio/dio.dart';
import 'package:valour/Util/AppEndPoints.dart';
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

  @GET(AppEndPoints.mappings)
  Future<dynamic> getMappings();

  @POST(AppEndPoints.mappings)
  Future<dynamic> addMapping({@Body() required Map<String, dynamic> body});

  @GET(AppEndPoints.routePlan)
  Future<dynamic> getRoutePlans();

  @POST(AppEndPoints.routePlan)
  Future<dynamic> addRoutePlan({@Body() required Map<String, dynamic> body});

  @GET(AppEndPoints.sales)
  Future<dynamic> getSales();

  @GET(AppEndPoints.products)
  Future<dynamic> getProducts();

  @GET(AppEndPoints.visits)
  Future<dynamic> getVisits();

  @POST(AppEndPoints.visits)
  Future<dynamic> addVisit({@Body() required Map<String, dynamic> body});

  @GET(AppEndPoints.deliveries)
  Future<dynamic> getDeliveries();

  @GET(AppEndPoints.appointments)
  Future<dynamic> getAppointments();

  @GET(AppEndPoints.maintenance)
  Future<dynamic> getMaintenance();

  @GET(AppEndPoints.demos)
  Future<dynamic> getDemos();
}

