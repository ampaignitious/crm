import 'package:crm/Screens/DefaultScreen.dart';
// ignore: unused_import
import 'package:crm/Screens/SplashScreen/FirstScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
Future<void> checkAndRequestLocationPermission() async {
  PermissionStatus status = await Permission.locationWhenInUse.status;

  if (status.isDenied) {
    // Request permission
    status = await Permission.locationWhenInUse.request();

    if (status.isGranted) {
      // Permission granted, proceed with location-based operations
      // ...
    }
  }
}
  @override
  Widget build(BuildContext context) {
    checkAndRequestLocationPermission();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const FirstScreen(),
      home: DefaultScreen(),
    );
  }
}

 
