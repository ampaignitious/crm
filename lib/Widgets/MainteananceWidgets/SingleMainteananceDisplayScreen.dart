import 'package:aiDvantage/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SingleMainteananceDisplayScreen extends StatefulWidget {
  String? mainteanancePurpose;
  String? mainteananceDetails;
    SingleMainteananceDisplayScreen({super.key, this.mainteananceDetails, this.mainteanancePurpose});

  @override
  State<SingleMainteananceDisplayScreen> createState() => _SingleMainteananceDisplayScreenState( this.mainteananceDetails, this.mainteanancePurpose);
}

class _SingleMainteananceDisplayScreenState extends State<SingleMainteananceDisplayScreen> {
    String? mainteanancePurpose;
  String? mainteananceDetails;
   _SingleMainteananceDisplayScreenState( this.mainteananceDetails, this.mainteanancePurpose);
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
            appBar: AppBar(
        iconTheme: IconThemeData(
        color: AppColors.contentColorPurple,
        size: size.width*0.08,
        ),  // Change the icon color here
        elevation: 0,
        backgroundColor: AppColors.contentColorCyan,
 
        title: Padding(
          padding: EdgeInsets.only(left: size.width*0.03),
          child: Text("More information about the mainteanance",
           style: GoogleFonts.lato(
            fontSize: size.width*0.038,
            color: AppColors.menuBackground,
            fontWeight: FontWeight.bold
          ),),
        ),
 
      ),
      body: Column(
        children: [
           Container(
          height: size.height*0.29,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: AppColors.contentColorCyan,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: Offset(0.8, 1.0),
                  blurRadius: 4.0,
                  spreadRadius: 0.2,
                ),
              ],
                      // borderRadius: BorderRadius.circular(10),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Lottie.asset(
                      'assets/json/readmore.json', // Path to your Lottie animation JSON file
                      width: size.width*0.46, // Adjust width as needed
                      height: size.height*0.27,  
                      fit: BoxFit.fill,
                        ),
                ),
              ],
            ),
          ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.only(left: size.width*0.06),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 
                SizedBox(height: size.height*0.014,),
                Text("Mainteanance purpose", style: GoogleFonts.lato(
                      fontSize:size.width*0.05,
                      fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height:size.height*0.008),
                    Text("${mainteanancePurpose}"),
                    Divider(),
                    Text("Business location", style: GoogleFonts.lato(
                      fontSize:size.width*0.05,
                      fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height:size.height*0.008),
                    Text("Kampala, Makerere"),
                    Text("Contact personnel", style: GoogleFonts.lato(
                      fontSize:size.width*0.05,
                      fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height:size.height*0.008),
                    Text("Aine Derrick"),
                    Divider(),
                    Text("Mainteanance description", style: GoogleFonts.lato(
                      fontSize:size.width*0.05,
                      fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height:size.height*0.008),
                    Text("${mainteananceDetails}"),
                    // 
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.av_timer_sharp),
                            Text("Start time: 2:20pm"),
                          ],
                        ),
                        // 
                        Row(
                          children: [
                            Icon(Icons.date_range),
                            Text("Date: 2/20/2023"),
                          ],
                        )
                      ],
                    )
                // 
              ],),
            ),
          )
        ],
      ),
    );
  }
}