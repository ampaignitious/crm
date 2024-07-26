import 'package:vfu/Screens/AuthenticationSceens/LoginScreen.dart';
import 'package:vfu/Screens/AuthenticationSceens/Register.dart';
import 'package:vfu/Screens/DefaultScreen.dart';
import 'package:vfu/Screens/SalesActivityPage.dart';
import 'package:vfu/Screens/SplashScreen/FirstScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart'; // Import get package
import 'package:provider/provider.dart';

import 'providers/UserTypeProvider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserTypeProvider(),
      child: const MyApp(), // Replace with your actual app widget
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Use GetMaterialApp instead of MaterialApp
      debugShowCheckedModeBanner: false,
      title: 'VFU Arrears And Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/loading', // Set initial route to loading screen
      getPages: [
        GetPage(
            name: '/loading',
            page: () => const LoadingScreen()), // Define loading screen route
        GetPage(
            name: '/first',
            page: () => const FirstScreen()), // Define first screen route
        GetPage(
            name: '/default',
            page: () => const DefaultScreen()), // Define default screen route
        GetPage(
            name: '/login',
            page: () => const LoginScreen()), // Define login screen route
        GetPage(
            name: '/register',
            page: () => const Register()), // Define register screen route
        GetPage(
            name: '/sales-activity',
            page: () =>
                const SalesActivityPage()), // Define sales activity screen route
      ],
    );
  }
}

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    // Fetch data and determine next screen
    final prefs = await SharedPreferences.getInstance();
    int launchCount = prefs.getInt('counter') ?? 0;
    prefs.setInt('counter', launchCount + 1);
    bool isFirstLaunch = launchCount == 0;
    String staffId = prefs.getString('username') ?? '';
    bool isLoggedIn = staffId.isNotEmpty;

    // Navigate to appropriate screen
    if (isFirstLaunch) {
      Get.offNamed('/first');
    } else if (isLoggedIn) {
      Get.offNamed('/default');
    } else {
      Get.offNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Colors.blue,
          ),
        ),
      ),
    );
  }
}
