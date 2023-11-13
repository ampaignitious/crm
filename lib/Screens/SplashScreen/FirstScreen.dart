import 'package:valour/Screens/SplashScreen/FirstSplashPage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
    void initState() {
    super.initState();

    // Delay for 3 seconds and then navigate to SplashScreen1
    Future.delayed(Duration(seconds: 5), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FirstSplashPage()),
      );
    });
  }
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Lottie.asset(
      'assets/json/apploading.json', // Path to your Lottie animation JSON file
      width: size.width*0.55, // Adjust width as needed
      height: size.height*0.28, // Adjust height as needed
      fit: BoxFit.fill,
        )
      ),
    );
  }
}