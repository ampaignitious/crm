import 'package:valour/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SingleRouteViewScreen extends StatefulWidget {
  final String routeName;
  final String routeDescription;
  final String routeStartLocation;
  final String routeEndLocation;
  const SingleRouteViewScreen({super.key, required this.routeDescription, required this.routeName, required this.routeStartLocation, required this.routeEndLocation});

  @override
  SingleRouteViewScreenState createState() => SingleRouteViewScreenState();

}

class SingleRouteViewScreenState extends State<SingleRouteViewScreen> {
  String? visitName;
 String? visitDescription;
  @override
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
                Text(widget.routeName),
                Divider(),
                Text("Start location", style: GoogleFonts.lato(
                  fontSize:size.width*0.05,
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(height:size.height*0.008),
                Text(widget.routeStartLocation),
                Divider(),
                Text("End location", style: GoogleFonts.lato(
                  fontSize:size.width*0.05,
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(height:size.height*0.008),
                Text(widget.routeEndLocation),
                Divider(),
                SizedBox(height:size.height*0.008),
                Text("Route details", style: GoogleFonts.lato(
                  fontSize:size.width*0.05,
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(height:size.height*0.008),
                Text(widget.routeDescription),
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