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

}
