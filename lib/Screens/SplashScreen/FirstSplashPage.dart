import 'package:crm/Screens/SplashScreen/SecondSplashPage.dart';
import 'package:crm/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
 

class FirstSplashPage extends StatefulWidget {
  const FirstSplashPage({super.key});

  @override
  State<FirstSplashPage> createState() => _FirstSplashPageState();
}

class _FirstSplashPageState extends State<FirstSplashPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        SizedBox(height: size.height*0.08,),
        Center(child: Text("Welcome to CRM application", style: GoogleFonts.lato(
          fontSize: size.width*0.065,
          fontWeight: FontWeight.bold,
          color: AppColors.darkRoast,
        ),)),
        SizedBox(height: size.height*0.10,),
        Center(
          child: Lottie.asset(
        'assets/json/coffeemachine.json', // Path to your Lottie animation JSON file
        width: size.width*0.6, // Adjust width as needed
        height: size.height*0.32, // Adjust height as needed
        fit: BoxFit.fill,
          )
        ),
        SizedBox(height: size.height*0.10,),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width*0.05
          ),
          child: Center(child: Text("Are you in need of a coffee machine for your business? then we are here to make your dream a reality", style: GoogleFonts.lato(
            fontSize: size.width*0.036,
            fontWeight: FontWeight.bold,
            color: AppColors.darkRoast,
          ),
          textAlign: TextAlign.center,
          ),),
        ),
        SizedBox(height: size.height*0.05,),
        InkWell(
          onTap: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
              return SecondSplashPage();
            }));
          },
          child: Center(
            child: Lottie.asset(
          'assets/json/next.json', // Path to your Lottie animation JSON file
          width: size.width*0.48, // Adjust width as needed
          height: size.height*0.2, // Adjust height as needed
          fit: BoxFit.fill,
            )
          ),
        ),
          ],
        ),
      )),
    );
  }
}