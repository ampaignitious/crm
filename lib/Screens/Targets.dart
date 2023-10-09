import 'package:crm/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Targets extends StatefulWidget {
  const Targets({super.key});

  @override
  State<Targets> createState() => _TargetsState();
}

class _TargetsState extends State<Targets> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
        color: AppColors.contentColorPurple,
        size: size.width*0.11,
        ),  // Change the icon color here
        elevation: 0.6,
        backgroundColor: AppColors.contentColorCyan,
 
        title: Padding(
          padding: EdgeInsets.only(left: size.width*0.06),
          child: Text("Targets page",
           style: GoogleFonts.lato(
            fontSize: size.width*0.05, 
            color: AppColors.menuBackground,
            fontWeight: FontWeight.bold
          ),),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: size.width*0.03,
            ),
            child: Lottie.asset(
            'assets/json/notification.json', // Path to your Lottie animation JSON file
            width: size.width*0.16, // Adjust width as needed
            height: size.height*0.14,  
            fit: BoxFit.fill,
              ),
          ),
        ],
      ),
    );
  }
}