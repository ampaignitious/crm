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

  @DELETE(AppEndPoints.deleteProfile)
  Future<dynamic> deleteProfile();

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

  @PUT(AppEndPoints.updateProducts)
  Future<dynamic> updateProduct(
      {@Path("product") required int product,
      @Body() required Map<String, dynamic> body});

  @DELETE(AppEndPoints.deleteProducts)
  Future<dynamic> deleteProduct({@Path("product") required int product});

  @PUT(AppEndPoints.updateQuantityProducts)
  Future<dynamic> updateQuantityProduct(
      {@Path("product") required int product,
      @Body() required Map<String, dynamic> body});

  @GET(AppEndPoints.coffeeProducts)
  Future<dynamic> getCoffeeProducts();

  @GET(AppEndPoints.coffeeMachines)
  Future<dynamic> getCoffeeMachines();

  @POST(AppEndPoints.products)
  Future<dynamic> addProduct({@Body() required Map<String, dynamic> body});

  @GET(AppEndPoints.visits)
  Future<dynamic> getVisits();

  @POST(AppEndPoints.visits)
  Future<dynamic> addVisit({@Body() required Map<String, dynamic> body});

  @GET(AppEndPoints.deliveries)
  Future<dynamic> getDeliveries();

  @GET(AppEndPoints.appointments)
  Future<dynamic> getAppointments();

  @GET(AppEndPoints.maintenances)
  Future<dynamic> getMaintenances();

  @GET(AppEndPoints.demos)
  Future<dynamic> getDemos();

  @GET(AppEndPoints.contacts)
  Future<dynamic> getContacts();
}

