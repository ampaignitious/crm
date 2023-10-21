import 'package:crm/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class SingleRouteViewScreen extends StatefulWidget {
  String? visitName;
 String? visitDescription;
  SingleRouteViewScreen({super.key, this.visitDescription, this.visitName});

  @override
  State<SingleRouteViewScreen> createState() => _SingleRouteViewScreenState( this.visitDescription, this.visitName);
}

class _SingleRouteViewScreenState extends State<SingleRouteViewScreen> {
  String? visitName;
 String? visitDescription;
  _SingleRouteViewScreenState( this.visitDescription, this.visitName);
  Widget build(BuildContext context) {
  final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.contentColorCyan,
        iconTheme: IconThemeData(
        color: AppColors.contentColorPurple,
        size: size.width*0.11,
        ),
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.only(left: size.width*0.06),
          child: Text("More information about the route plan",
           style: GoogleFonts.lato(
            fontSize: size.width*0.040, 
            color: AppColors.contentColorPurple,
            fontWeight: FontWeight.bold
          ),),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Padding(
            padding: EdgeInsets.only(left:size.width*0.06, top: size.height*0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Route name", style: GoogleFonts.lato(
                  fontSize:size.width*0.05,
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(height:size.height*0.008),
                Text("${visitName}"),
                Divider(),
                Text("Start location", style: GoogleFonts.lato(
                  fontSize:size.width*0.05,
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(height:size.height*0.008),
                Text("Ntinda"),
                Divider(),
                Text("End location", style: GoogleFonts.lato(
                  fontSize:size.width*0.05,
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(height:size.height*0.008),
                Text("Kampala, Makerere"),
                Divider(),
                SizedBox(height:size.height*0.008),
                Text("Route details", style: GoogleFonts.lato(
                  fontSize:size.width*0.05,
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(height:size.height*0.008),
                Text("${visitDescription}"),
                // 
                SizedBox(height:size.height*0.008),
                Text("Number of target visits to make", style: GoogleFonts.lato(
                  fontSize:size.width*0.05,
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(height:size.height*0.008),
                Text("10"),
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
              ],
            ),
          )

        ],
      ),
    );
  }
}