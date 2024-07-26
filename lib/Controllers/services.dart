import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:vfu/Models/User.dart';
import 'endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static String ACCESS_TOKEN = "access_token";

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    final dio = Dio();
    final client = RestClient(dio);
    try {
      Map<String, String> user = {"username": email, "password": password};
      final response = await client.signIn(body: user);
      if (response.containsKey('authorization') &&
          response['authorization'].containsKey('token')) {
        final accessToken = response['authorization']['token'];
        await saveAccessToken(accessToken);
        await saveUserDetails(
            response['user']['names'],
            response['user']['username'],
            response['user']['staff_id'] ?? 0,
            response['user']['user_type'] ?? 0,
            response['user']['region_id'] ?? 0,
            response['user']['branch_id'] ?? 0);
        return response;
      } else {
        log("failed exception during login: $response");
        return {
          "error": "Invalid credentials",
          "status": "error",
        };
      } // Handle the case when the access token is not present in the response
    } catch (e) {
      log("failed exception happened during login: $e");
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

  saveUserDetails(
    String name,
    String username,
    int staffId,
    int userType,
    int regionId,
    int branchId,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("name", name);
    await prefs.setString("username", username);
    await prefs.setString("staff_id", staffId.toString());
    await prefs.setString("user_type", userType.toString());
    await prefs.setString("region_id", regionId.toString());
    await prefs.setString("branch_id", branchId.toString());
  }

  Future<User> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User userDetails = User(
        name: '',
        username: '',
        staffId: '',
        userType: '',
        regionId: '',
        branchId: '',
        status: '');

    //add name to user details
    userDetails.name = prefs.getString("name").toString();

    //add username to user details
    userDetails.username = prefs.getString("username").toString();

    userDetails.staffId = prefs.getString("staff_id").toString();

    userDetails.userType = prefs.getString("user_type").toString();

    //add region id to user details
    userDetails.regionId = prefs.getString("region_id").toString();

    userDetails.branchId = prefs.getString("branch_id").toString();

    //add status to user details
    userDetails.status = "success";

    return userDetails;
  }

  removeUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("name");
    await prefs.remove("username");
    await prefs.remove("staff_id");
    await prefs.remove("user_type");
    await prefs.remove("region_id");
    await prefs.remove("branch_id");
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
        await removeUserDetails();
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

  //getArrears
  Future<Map<String, dynamic>> getArrears(String group) async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    //accept application/json
    dio.options.headers['Accept'] = "application/json";
    //add the content type
    dio.options.headers['Content-Type'] = "application/json";

    final body = {"group": group};
    try {
      final response = await client.getArrears(body: body);
      //check if response contains message
      if (response.containsKey('message')) {
        return response;
      } else {
        log("failed exception during getArrears else: $response");
        return {
          "error": "Failed to get arrears",
          "status": "error",
        };
      }
    } catch (e) {
      log("failed exception happened during getArrears: $e");
      return {
        "error": "Failed to get arrears",
        "status": "error",
      };
    }
  }

  //getSales
  Future<Map<String, dynamic>> getSales(String group) async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    //accept application/json
    dio.options.headers['Accept'] = "application/json";
    //add the content type
    dio.options.headers['Content-Type'] = "application/json";

    final body = {"group": group};
    try {
      final response = await client.getSales(body: body);
      //check if response contains message
      if (response.containsKey('message')) {
        return response;
      } else {
        return {
          "error": "Failed to get sales",
          "status": "error",
        };
      }
    } catch (e) {
      return {
        "error": "Failed to get sales",
        "status": "error",
      };
    }
  }

  //getExpected
  Future<Map<String, dynamic>> getExpected(String group) async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    //accept application/json
    dio.options.headers['Accept'] = "application/json";
    //add the content type
    dio.options.headers['Content-Type'] = "application/json";

    //Charset utf8
    dio.options.headers['charset'] = "utf-8";

    final body = {"group": group};
    try {
      final response = await client.getExpected(body: body);
      //check if response contains message
      if (response.containsKey('message')) {
        return response;
      } else {
        log("failed exception during getExpected else: $response");
        return {
          "error": "Failed to get expected",
          "status": "error",
        };
      }
    } catch (e) {
      log("failed exception happened during getExpected: $e");
      return {
        "error": "Failed to get expected",
        "status": "error",
      };
    }
  }

  Future<Map<String, dynamic>> getIncentives() async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    //accept application/json
    dio.options.headers['Accept'] = "application/json";
    //add the content type
    dio.options.headers['Content-Type'] = "application/json";

    //Charset utf8
    dio.options.headers['charset'] = "utf-8";

    try {
      final response = await client.getIncentives();
      //check if response contains message
      if (response.containsKey('message')) {
        log("response['incentives']: ${response['incentives']}");
        return response['incentives'];
      } else {
        log("failed exception during getIncentives else: $response");
        return {
          "error": "Failed to get incentives",
          "status": "error",
        };
      }
    } catch (e) {
      log("failed exception happened during getIncentives: $e");
      return {
        "error": "Failed to get incentives",
        "status": "error",
      };
    }
  }

  //getDashboard
  Future<Map<String, dynamic>> getDashboard() async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    //accept application/json
    dio.options.headers['Accept'] = "application/json";
    //add the content type
    dio.options.headers['Content-Type'] = "application/json";

    try {
      final response = await client.getDashboard();
      //check if response contains message
      if (response.containsKey('message')) {
        return response;
      } else {
        return {
          "error": "Failed to get dashboard",
          "status": "error",
        };
      }
    } catch (e) {
      return {
        "error": "Failed to get dashboard",
        "status": "error",
      };
    }
  }

  //getMonitors
  Future<Map<String, dynamic>> getMonitors(String activity) async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    //accept application/json
    dio.options.headers['Accept'] = "application/json";
    //add the content type
    dio.options.headers['Content-Type'] = "application/json";

    try {
      final response = await client.getMonitors(activity);
      //check if response contains message
      if (response.containsKey('message')) {
        return response;
      } else {
        return {
          "error": "Failed to get monitors",
          "status": "error",
        };
      }
    } catch (e) {
      return {
        "error": "Failed to get monitors",
        "status": "error",
      };
    }
  }

  //apply
  Future<bool> apply(int monitorId) async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    //accept application/json
    dio.options.headers['Accept'] = "application/json";
    //add the content type
    dio.options.headers['Content-Type'] = "application/json";

    final body = {"monitor_id": monitorId};
    try {
      final response = await client.apply(body: body);
      //check if response contains message
      if (response.containsKey('message')) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("failed exception happened during apply: $e");
      return false;
    }
  }

  //appraise
  Future<bool> appraise(int monitorId) async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    //accept application/json
    dio.options.headers['Accept'] = "application/json";
    //add the content type
    dio.options.headers['Content-Type'] = "application/json";

    final body = {"monitor_id": monitorId};
    try {
      final response = await client.appraise(body: body);
      //check if response contains message
      if (response.containsKey('message')) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("failed exception happened during appraise: $e");
      return false;
    }
  }

  //createMonitor
  Future<bool> createMonitor(
      String name, String phone, String location, String activity) async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    //accept application/json
    dio.options.headers['Accept'] = "application/json";
    //add the content type
    dio.options.headers['Content-Type'] = "application/json";

    final body = {
      "name": name,
      "phone": phone,
      "location": location,
      "activity": activity
    };
    try {
      final response = await client.createMonitor(body: body);
      //check if response contains message
      if (response.containsKey('message')) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("failed exception happened during createMonitor: $e");
      return false;
    }
  }

  //add comment with comment, customer_id, staff_id
  Future<bool> addComment(
      String comment, String customerId, String numberOfDayLate) async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    //accept application/json
    dio.options.headers['Content-Type'] = "application/json";

    final body = {
      "comment": comment,
      "customer_id": customerId,
      'number_of_days_late': numberOfDayLate,
    };
    try {
      final response = await client.addComment(body: body);
      //check if response contains message
      if (response.containsKey('comment')) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("failed exception happened during addComment: $e");
      return false;
    }
  }

  //show all comments that belong to a customer
  Future<Map<String, dynamic>> showAllComments(String customerId) async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    //accept application/json
    dio.options.headers['Content-Type'] = "application/json";

    try {
      final response = await client.showAllComments(customerId);
      //check if response contains message
      if (response.containsKey('comments')) {
        return response;
      } else {
        log("no comments field: $response");
        return {
          "error": "Failed to get comments",
          "status": "error",
        };
      }
    } catch (e) {
      log("failed exception happened during showAllComments: $e");
      return {
        "error": "Failed to get comments",
        "status": "error",
      };
    }
  }

  //get all comments
  Future<Map<String, dynamic>> getAllComments() async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    //accept application/json
    dio.options.headers['Content-Type'] = "application/json";

    try {
      final response = await client.getAllComments();
      //check if response contains message
      if (response.containsKey('comments')) {
        return response;
      } else {
        return {
          "error": "Failed to get comments",
          "status": "error",
        };
      }
    } catch (e) {
      return {
        "error": "Failed to get comments",
        "status": "error",
      };
    }
  }
}
