// ignore: unused_import
import 'package:vfu/Screens/AuthenticationSceens/LoginScreen.dart';
import 'package:vfu/Screens/AuthenticationSceens/Register.dart';
import 'package:vfu/Screens/DefaultScreen.dart';
import 'package:vfu/Screens/SplashScreen/FirstScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    // Set loading to true while data is being fetched
    setState(() {
      isLoading = true;
    });

    await Future.wait([setValue(), checkStaffId()]);

    setState(() {
      isLoading = false;
    });
  }

  Future<void> setValue() async {
    final prefs = await SharedPreferences.getInstance();
    int launchCount = prefs.getInt('counter') ?? 0;
    prefs.setInt('counter', launchCount + 1);
    if (launchCount == 0) {
      // If it's the first launch, return true.
      isFirstLaunch = true;
    } else {
      // If it's not the first launch, return false.
      isFirstLaunch = false;
    }
  }

  Future<void> checkStaffId() async {
    final prefs = await SharedPreferences.getInstance();
    String staffId = prefs.getString('username') ?? '';
    if (staffId == '') {
      isLoggedIn = false;
    } else {
      isLoggedIn = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VFU Arrears And Tracker',
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
              : isLoggedIn
                  ? const DefaultScreen()
                  : const LoginScreen(),
      routes: {
        '/register': (context) => const Register(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}
