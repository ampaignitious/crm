import 'package:vfu/Screens/SplashScreen/FirstSplashPage.dart';
import 'package:vfu/Screens/SplashScreen/ThirdSplashScreen.dart';
import 'package:vfu/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SecondSplashPage extends StatefulWidget {
  const SecondSplashPage({super.key});

  @override
  State<SecondSplashPage> createState() => _SecondSplashPageState();
}

class _SecondSplashPageState extends State<SecondSplashPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.08,
            ),
            Center(
                child: Text(
              "Know your incentive status from the go ?",
              style: GoogleFonts.lato(
                fontSize: size.width * 0.065,
                fontWeight: FontWeight.bold,
                color: AppColors.darkRoast,
              ),
              textAlign: TextAlign.center,
            )),
            SizedBox(
              height: size.height * 0.05,
            ),
            Center(
                child: Lottie.asset(
              'assets/json/coffeetest.json', // Path to your Lottie animation JSON file
              width: size.width * 0.6, // Adjust width as needed
              height: size.height * 0.32, // Adjust height as needed
              fit: BoxFit.fill,
            )),
            SizedBox(
              height: size.height * 0.03,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Center(
                child: Text(
                  "Do you want to track your incentive status from the go? Let's get started!",
                  style: GoogleFonts.lato(
                    fontSize: size.width * 0.036,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkRoast,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: size.width * 0.32, // Adjust width as needed
                  height: size.height * 0.08,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.contentColorOrange)),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const FirstSplashPage();
                      }));
                    },
                    child: Center(
                        child: Lottie.asset(
                      'assets/json/back.json', // Path to your Lottie animation JSON file
                      width: size.width * 0.35, // Adjust width as needed
                      height: size.height * 0.15,
                      fit: BoxFit.fill,
                    )),
                  ),
                ),
                //
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ThirdSplashScreen();
                    }));
                  },
                  child: Center(
                      child: Lottie.asset(
                    'assets/json/next.json', // Path to your Lottie animation JSON file
                    width: size.width * 0.42, // Adjust width as needed
                    height: size.height * 0.18,
                    fit: BoxFit.fill,
                  )),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
