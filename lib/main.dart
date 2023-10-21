// ignore: unused_import
import 'package:crm/Screens/DefaultScreen.dart';
import 'package:crm/Screens/SplashScreen/FirstScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,overlays: []);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // SystemChrome.setSystemUIOverlayStyle(style)
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
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

 
