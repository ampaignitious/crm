// ignore: unused_import
import 'package:aiDvantage/Screens/AuthenticationSceens/LoginScreen.dart';
import 'package:aiDvantage/Screens/SplashScreen/FirstScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isFirstLaunch = true;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    setValue().then((isFirstLaunch) {
      setState(() {
        this.isFirstLaunch = isFirstLaunch;
        isLoading =
            false; // Set loading to false once the operation is complete
      });
    });
  }

  Future<bool> setValue() async {
    final prefs = await SharedPreferences.getInstance();
    int launchCount = prefs.getInt('counter') ?? 0;
    prefs.setInt('counter', launchCount + 1);
    if (launchCount == 0) {
      // If it's the first launch, return true.
      return true;
    } else {
      // If it's not the first launch, return false.
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isLoading
          ? const Scaffold(
              backgroundColor:
                  Colors.white, // Set the background color to white
              body: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.blue, // Set the color of the spinner
                  ),
                ),
              ),
            )
          : isFirstLaunch
              ? const FirstScreen()
              : const LoginScreen(),
    );
  }
}
