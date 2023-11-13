import 'package:valour/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class SingleNotificationDisplayScreen extends StatefulWidget {
    String? subject;
    String? description;
    String? time;
    SingleNotificationDisplayScreen({super.key, this.subject, this.description, this.time});

  @override
  State<SingleNotificationDisplayScreen> createState() => _SingleNotificationDisplayScreenState(this.subject, this.description, this.time);
}

class _SingleNotificationDisplayScreenState extends State<SingleNotificationDisplayScreen> {
  String? subject;
  String? description;
  String? time;
  _SingleNotificationDisplayScreenState(this.subject, this.description, this.time);
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
        color: AppColors.contentColorPurple,
        size: size.width*0.08,
        ),  // Change the icon color here
        elevation: 0.6,
        backgroundColor: AppColors.contentColorCyan,
 
        title: Padding(
          padding: EdgeInsets.only(left: size.width*0.06),
          child: Text("Notification details",
           style: GoogleFonts.lato(
            fontSize: size.width*0.05, 
            color: AppColors.contentColorPurple,
            fontWeight: FontWeight.bold
          ),),
        ),
      ),
      body: Center(
        child: Container(
          height: size.height*0.6,
          width: size.width*0.90,
          decoration: BoxDecoration(
            color: AppColors.contentColorCyan,
            border: Border.all(
              color: AppColors.contentColorPurple.withOpacity(0.3)
            ),
            borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height*0.010,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: size.width*0.03),
                    child: Text("${subject}", style:GoogleFonts.lato(
                      fontSize:size.width*0.055,
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: size.width*0.03),
                    // child: Icon(Icons.delete_forever,
                    // color: AppColors.contentColorPurple,
                    // ),
                    child: Lottie.asset(
                    'assets/json/delete.json', // Path to your Lottie animation JSON file
                    width: size.width*0.13, // Adjust width as needed
                    height: size.height*0.065,  
                    fit: BoxFit.fill,
                      ),
                  )
                ],
              ),
              Divider(),
              Padding(
                padding:EdgeInsets.symmetric(
                  horizontal: size.width*0.03,
                ),
                child: Text("Description", style: GoogleFonts.lato(
                color: AppColors.contentColorPurple,
                fontWeight: FontWeight.bold
                ),),
              ),
              Padding(
                padding:EdgeInsets.symmetric(
                  vertical: size.height*0.01,
                  horizontal: size.width*0.03,
                ),
                child: Text("${description}", style: GoogleFonts.lato(
              
                ),),
              ),
              SizedBox(height: size.height*0.04,),
              Divider(),
              Padding(
                padding:EdgeInsets.symmetric(horizontal: size.width*0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.timelapse_rounded, 
                        size: size.width*0.07,
                        color: AppColors.contentColorPurple,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: size.width*0.03),
                          child: Text("${time}", style: GoogleFonts.lato(
                            fontSize:size.width*0.045
                          ),),
                        )
                      ],
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.date_range, 
                        size: size.width*0.07,
                        color: AppColors.contentColorPurple,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: size.width*0.03),
                          child: Text("10/2/2024", style: GoogleFonts.lato(
                            fontSize:size.width*0.045
                          ),),
                        )
                      ],
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}