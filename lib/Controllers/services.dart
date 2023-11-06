import 'package:dio/dio.dart';
import 'endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthController {
  static String ACCESS_TOKEN = "access_token";

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    final dio = Dio();
    final client = RestClient(dio);
    try {
      Map<String, String> user = {"email": email, "password": password};
      final response = await client.signIn(body: user);
      print('Response: $response');

      if (response.containsKey('authorization') &&
          response['authorization'].containsKey('token')) {
        final accessToken = response['authorization']['token'];
        await saveAccessToken(accessToken);
        return response;
      } else {
        return {
          "error": "Invalid credentials",
          "status": "error",
        };
      } // Handle the case when the access token is not present in the response
    } catch (e) {
      return {
        "error": "Invalid credentials",
        "status": "error",
      };
    }
  }

  saveAccessToken(String accessToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(ACCESS_TOKEN, accessToken);
  }

  saveUserData(String userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("userData", userData);
  }

  getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(ACCESS_TOKEN)) {
      return "";
    }
    return prefs.getString(ACCESS_TOKEN);
  }

  Future<Map<String, dynamic>> signOut() async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    try {
      final response = await client.signOut();
      return response;
    } catch (e) {
      return {
        "error": "Failed to sign out",
        "status": "error",
      };
    }
  }

  Future<Map<String, dynamic>> getMappings() async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    try {
      final response = await client.getMappings();
      return response;
    } catch (e) {
      return {
        "error": "Failed to get mappings",
        "status": "error",
      };
    }
  }

  Future<Map<String, dynamic>> addMapping(
      Map<String, String> businessDetails) async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    try {
      final response = await client.addMapping(body: businessDetails);
      return response;
    } catch (e) {
      return {
        "error": "Failed to add mapping",
        "status": "error",
      };
    }
  }

  Future<Map<String, dynamic>> getRoutePlan() async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    try {
      final response = await client.getRoutePlan();
      return response;
    } catch (e) {
      return {
        "error": "Failed to get route plan",
        "status": "error",
      };
    }
  }

  Future<Map<String, dynamic>> addRoutePlan(
      String name, String email, String password, String role) async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    try {
      Map<String, String> user = {
        "name": name,
        "email": email,
        "password": password,
        "role": role
      };
      final response = await client.addRoutePlan(body: user);
      return response;
    } catch (e) {
      return {
        "error": "Failed to add route plan",
        "status": "error",
      };
    }
  }

  Future<Map<String, dynamic>> getSales() async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    try {
      final response = await client.getSales();
      return response;
    } catch (e) {
      return {
        "error": "Failed to get sales",
        "status": "error",
      };
    }
  }

  Future<Map<String, dynamic>> getProducts() async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    try {
      final response = await client.getProducts();
      return response;
    } catch (e) {
      return {
        "error": "Failed to get products",
        "status": "error",
      };
    }
  }

  Future<Map<String, dynamic>> getVisits() async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    try {
      final response = await client.getVisits();
      return response;
    } catch (e) {
      return {
        "error": "Failed to get visits",
        "status": "error",
      };
    }
  }

  Future<Map<String, dynamic>> addVisit(
      String name, String email, String password, String role) async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    try {
      Map<String, String> user = {
        "name": name,
        "email": email,
        "password": password,
        "role": role
      };
      final response = await client.addVisit(body: user);
      return response;
    } catch (e) {
      return {
        "error": "Failed to add visit",
        "status": "error",
      };
    }
  }

  Future<Map<String, dynamic>> getDeliveries() async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";

    try {
      final response = await client.getDeliveries();
      return response;
    } catch (e) {
      return {
        "error": "Failed to get deliveries",
        "status": "error",
      };
    }
  }

  Future<Map<String, dynamic>> getAppointments() async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";

    try {
      final response = await client.getAppointments();
      return response;
    } catch (e) {
      return {
        "error": "Failed to get appointments",
        "status": "error",
      };
    }
  }

  Future<Map<String, dynamic>> getMaintenance() async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";

    try {
      final response = await client.getMaintenance();
      return response;
    } catch (e) {
      return {
        "error": "Failed to get maintenance",
        "status": "error",
      };
    }
  }

  Future<Map<String, dynamic>> getDemos() async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";

    try {
      final response = await client.getDemos();
      return response;
    } catch (e) {
      return {
        "error": "Failed to get demos",
        "status": "error",
      };
    }
  }
}
