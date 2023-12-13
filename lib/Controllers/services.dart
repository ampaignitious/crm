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

  Future<Map<String, dynamic>> getProfile() async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    try {
      final response = await client.getProfile();
      //check if the response contains message key
      if (response.containsKey('message')) {
        return response;
      } else {
        return {
          "error": "Invalid credentials",
          "status": "error",
        };
      }
    } catch (e) {
      return {
        "error": "Invalid credentials",
        "status": "error",
      };
    }
  }

  Future<Map<String, dynamic>> signUp(
      String name, String email, String password) async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Accept'] = "application/json";
    try {
      Map<String, String> user = {
        "name": name,
        "email": email,
        "password": password
      };
      final response = await client.signUp(body: user);

      //check if the response contains message key
      if (response.containsKey('message')) {
        return response;
      } else {
        return {
          "error": "Invalid credentials",
          "status": "error",
        };
      }
    } catch (e) {
      print("save error: $e");
      return {
        "error": "Invalid credentials",
        "status": "error",
      };
    }
  }

  Future<Map<String, dynamic>> deleteProfile() async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Accept'] = "application/json";
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    try {
      
      final response = await client.deleteProfile();
      //check if the response contains message key
      if (response.containsKey('message')) {
        return response;
      } else {
        return {
          "error": "Invalid credentials",
          "status": "error",
        };
      }
    } catch (e) {
      print("delete error: $e");
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

  getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(ACCESS_TOKEN)) {
      return "";
    }
    return prefs.getString(ACCESS_TOKEN);
  }

  removeAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(ACCESS_TOKEN);
  }

  Future<Map<String, dynamic>> signOut() async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    //accept application/json
    dio.options.headers['Accept'] = "application/json";
    try {
      final response = await client.signOut();
      //check if response contains message
      if (response.containsKey('message')) {
        await removeAccessToken();
        return response;
      } else {
        return {
          "error": "Failed to sign out",
          "status": "error",
        };
      }
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
      //check if response contains message
      if (response.containsKey('message')) {
        //calculate the number of businesses
        return response;
      } else {
        return {
          "error": "Failed to get mappings",
          "status": "error",
        };
      }
    } catch (e) {
      return {
        "error": "Failed to get mappings",
        "status": "error",
      };
    }
  }

  //calculate the number of businesses
  Future<int> getNumberOfBusinesses() async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";

    try {
      final response = await client.getMappings();
      //check if response contains message
      if (response.containsKey('message')) {
        //calculate the number of businesses
        int numbeOfBusinesses = response['data'].length;
        return numbeOfBusinesses;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

  Future<Map<String, dynamic>> addMapping(
      Map<String, dynamic> businessDetails) async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    dio.options.headers['Accept'] = "application/json";
    try {
      final response = await client.addMapping(body: businessDetails);
      if (response.containsKey('message')) {
        return {
          "message": "Mapping added successfully",
          "status": "success",
        };
      } else {
        return {
          "error": "Failed to add mapping",
          "status": "error",
        };
      }
    } catch (e) {
      print("posting error: $e");
      return {
        "error": "Failed to add mapping",
        "status": "error",
      };
    }
  }

  Future<Map<String, dynamic>> getRoutePlans() async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    try {
      final response = await client.getRoutePlans();
      if (response.containsKey('message')) {
        return response;
      } else {
        return {
          "error": "Failed to get route plans",
          "status": "error",
        };
      }
    } catch (e) {
      return {
        "error": "Failed to get route plan",
        "status": "error",
      };
    }
  }

  Future<Map<String, dynamic>> addRoutePlan(Map<String, dynamic> body) async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    try {
      final response = await client.addRoutePlan(body: body);
      if (response.containsKey('message')) {
        return {
          "message": "Route plan added successfully",
          "status": "success",
        };
      } else {
        return {
          "error": "Failed to add route plan",
          "status": "error",
        };
      }
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
    dio.options.headers['Accept'] = "application/json";
    try {
      final response = await client.getProducts();
      if (response.containsKey('message')) {
        return response;
      } else {
        return {
          "error": "Failed to get products",
          "status": "error",
        };
      }
    } catch (e) {
      return {
        "error": "Failed to get products",
        "status": "error",
      };
    }
  }

  Future<Map<String, dynamic>> getCoffeeProducts() async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";

    try {
      final response = await client.getCoffeeProducts();
      if (response.containsKey('message')) {
        return response;
      } else {
        return {
          "error": "Failed to get coffee products",
          "status": "error",
        };
      }
    } catch (e) {
      return {
        "error": "Failed to get coffee products",
        "status": "error",
      };
    }
  }

  Future<Map<String, dynamic>> getCoffeeMachines() async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    dio.options.headers['Accept'] = "application/json";
    try {
      final response = await client.getCoffeeMachines();
      if (response.containsKey('message')) {
        return response;
      } else {
        return {
          "error": "Failed to get coffee machines",
          "status": "error",
        };
      }
    } catch (e) {
      print("status error code: $e");
      return {
        "error": "Failed to get coffee machines",
        "status": "error",
      };
    }
  }
  
  Future<Map<String, dynamic>> addProduct(Map<String, dynamic> body) async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    dio.options.headers['Accept'] = "application/json";
    try {
      final response = await client.addProduct(body: body);
      if (response.containsKey('message')) {
        return {
          "message": "Product added successfully",
          "status": "success",
        };
      } else {
        return {
          "error": "Failed to add product",
          "status": "error",
        };
      }
    } catch (e) {
      print("posting error: $e");
      return {
        "error": "Failed to add product",
        "status": "error",
      };
    }
  }

  Future<Map<String, dynamic>> updateProduct(
      int product, Map<String, dynamic> body) async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    dio.options.headers['Accept'] = "application/json";

    try {
      final response = await client.updateProduct(product: product, body: body);
      if (response.containsKey('message')) {
        return {
          "message": "Product updated successfully",
          "status": "success",
        };
      } else {
        return {
          "error": "Failed to update product",
          "status": "error",
        };
      }
    } catch (e) {
      print("posting error: $e");
      return {
        "error": "Failed to update product",
        "status": "error",
      };
    }
  }

  Future<Map<String, dynamic>> deleteProduct(int product) async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    dio.options.headers['Accept'] = "application/json";
    dio.options.validateStatus = (status) => status! < 500;
    try {
      final response = await client.deleteProduct(product: product);
      if (response.containsKey('message')) {
        return {
          "message": "Product deleted successfully",
          "status": "success",
        };
      } else if (response.containsKey('error')){
        return {
          "error": response['error'],
          "status": "error",
        };
      } else {
        return {
          "error": "Failed to delete product",
          "status": "error",
        };
      }
    } catch (e) {
      return {
        "error": "Failed to delete product",
        "status": "error",
      };
    }
  }

  Future<Map<String, dynamic>> updateQuantityProduct(
      int product, Map<String, dynamic> body) async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    dio.options.headers['Accept'] = "application/json";
    try {
      final response =
          await client.updateQuantityProduct(product: product, body: body);
      if (response.containsKey('message')) {
        return {
          "message": "Product quantity updated successfully",
          "status": "success",
          "data": response['data']
        };
      } else {
        return {
          "error": "Failed to update product quantity",
          "status": "error",
        };
      }
    } catch (e) {
      print("posting error: $e");
      return {
        "error": "Failed to update product quantity",
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
      Map<String, dynamic> visitDetails) async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    dio.options.headers['Accept'] = "application/json";
    try {
      final response = await client.addVisit(body: visitDetails);
      if (response.containsKey('message')) {
        return {
          "message": "Visit added successfully",
          "status": "success",
        };
      } else {
        return {
          "error": "Failed to add vsit",
          "status": "error",
        };
      }
    } catch (e) {
      return {
        "error": "Failed to add mapping",
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

  Future<Map<String, dynamic>> getMaintenances() async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    dio.options.headers['Accept'] = "application/json";

    try {
      final response = await client.getMaintenances();
      print("response: $response");
      //check if response contains message
      if (response.containsKey('message')) {
        return response;
      } else {
        return {
          "error": "Failed to get maintenances",
          "status": "error",
        };
      }
    } catch (e) {
      print("status error code: $e");
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

  Future<Map<String, dynamic>> getContacts() async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";

    try {
      final response = await client.getContacts();
      //check if response contains message
      if (response.containsKey('message')) {
        return response;
      } else {
        return {
          "error": "Failed to get contacts",
          "status": "error",
        };
      }
    } catch (e) {
      return {
        "error": "Failed to get contacts",
        "status": "error",
      };
    }
  }
}
