import 'package:vfu/Screens/AuthenticationSceens/LoginScreen.dart';
import 'package:vfu/Screens/SplashScreen/SecondSplashPage.dart';
import 'package:vfu/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ThirdSplashScreen extends StatefulWidget {
  const ThirdSplashScreen({super.key});

  @override
  State<ThirdSplashScreen> createState() => _ThirdSplashScreenState();
}

class _ThirdSplashScreenState extends State<ThirdSplashScreen> {
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
              child: Center(
                  child: Text(
                "Have all your VFU sales services on the go?",
                style: GoogleFonts.lato(
                  fontSize: size.width * 0.063,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkRoast,
                ),
                textAlign: TextAlign.center,
              )),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Center(
                child: Lottie.asset(
              'assets/json/delivery.json', // Path to your Lottie animation JSON file
              width: size.width * 0.9, // Adjust width as needed
              height: size.height * 0.38, // Adjust height as needed
              fit: BoxFit.fill,
            )),
            SizedBox(
              height: size.height * 0.03,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Center(
                child: Text(
                  "Track customers in arrears, monitor your sales and track your incentives with VFU application. Let's get started!",
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
              height: size.height * 0.09,
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
                        return const SecondSplashPage();
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
                      return const LoginScreen();
                    }));
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: size.width * 0.08),
                    height: size.height * 0.08,
                    width: size.width * 0.6,
                    decoration: BoxDecoration(
                        color: AppColors.contentColorOrange,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Get started",
                        style:
                            GoogleFonts.lato(color: AppColors.mainTextColor1),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      )),
    );
  }
}
