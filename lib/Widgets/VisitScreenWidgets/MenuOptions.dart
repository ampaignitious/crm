import 'package:crm/Utils/AppColors.dart';
import 'package:crm/Widgets/VisitScreenWidgets/CreateVisitScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class MenuOptions extends StatefulWidget {
  const MenuOptions({super.key});

  @override
  State<MenuOptions> createState() => _MenuOptionsState();
}

class _MenuOptionsState extends State<MenuOptions> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      SizedBox(height: size.height*0.030,),    
     Container(
            height: size.height*0.33,
            width: size.width*0.95,
            decoration: BoxDecoration(
              color: AppColors.contentColorCyan,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            offset: Offset(0.8, 1.0),
                            blurRadius: 4.0,
                            spreadRadius: 0.2,
                          ),
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            offset: Offset(0.8, 1.0),
                            blurRadius: 4.0,
                            spreadRadius: 0.2,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                   Lottie.asset(
                  'assets/json/registration.json', // Path to your Lottie animation JSON file
                  width: size.width*0.43, // Adjust width as needed
                  height: size.height*0.23,  
                  fit: BoxFit.fill,
                    ),
                    // this container displays stats on the add a visit container display section
                     Container(
                  height: size.height*0.19,
                  width: size.width*0.499,
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
                        borderRadius: BorderRadius.circular(10),
                   ),
                   child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height*0.015,),
                        Center(
                          child: Text("visit summary statistics",
                          style: GoogleFonts.lato(
                            fontSize:size.width*0.038,
                            fontWeight: FontWeight.bold,
                            color: AppColors.contentColorPurple,
                          ),
                          ),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: size.width*0.03),
                          child: Text("Assigned visits: 456",
                          style: GoogleFonts.lato(
                            fontSize:size.width*0.04,
                            color: AppColors.contentColorBlack,
                          ),
                          ),
                        ),
                        SizedBox(height: size.height*0.015,),
                        Padding(
                          padding: EdgeInsets.only(left: size.width*0.03),
                          child: Text("Accompolished visits: 120",
                          style: GoogleFonts.lato(
                            fontSize:size.width*0.038,
                            color: AppColors.contentColorBlack,
                          ),
                          ),
                        ),
                        SizedBox(height: size.height*0.019,),
                        Center(
                          child: Text("Total visits: 120",
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            fontSize:size.width*0.04,
                            color: AppColors.contentColorBlack,
                          ),
                          ),
                        ),
                      ],
                    ),
                   ),
                )
                    // 
                  ],
                ),
                // 
            ElevatedButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return CreateVisitScreen();
              }));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width*0.26,
                vertical: size.height*0.028,
              ),
              child: Text('record a visit'),
            ),
              style: ElevatedButton.styleFrom(
              primary: AppColors.contentColorPurple,  // Set button color to purple
            ),
          ),
              ],
            ),
    ),
    // second container
    SizedBox(height: size.height*0.030,),
    Container(
            height: size.height*0.33,
            width: size.width*0.95,
            decoration: BoxDecoration(
              color: AppColors.contentColorCyan,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            offset: Offset(0.8, 1.0),
                            blurRadius: 4.0,
                            spreadRadius: 0.2,
                          ),
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            offset: Offset(0.8, 1.0),
                            blurRadius: 4.0,
                            spreadRadius: 0.2,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                SizedBox(height: size.height*0.018,),
                Row(
                  children: [
                   Lottie.asset(
                  'assets/json/routeplan.json', // Path to your Lottie animation JSON file
                  width: size.width*0.43, // Adjust width as needed
                  height: size.height*0.18,  
                  fit: BoxFit.fill,
                    ),
                    // this container displays stats on the add a visit container display section
                     Container(
                  height: size.height*0.19,
                  width: size.width*0.499,
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
                        borderRadius: BorderRadius.circular(10),
                   ),
                   child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height*0.015,),
                        Center(
                          child: Text("visit summary statistics",
                          style: GoogleFonts.lato(
                            fontSize:size.width*0.038,
                            fontWeight: FontWeight.bold,
                            color: AppColors.contentColorPurple,
                          ),
                          ),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: size.width*0.03),
                          child: Text("Assigned visits: 456",
                          style: GoogleFonts.lato(
                            fontSize:size.width*0.04,
                            color: AppColors.contentColorBlack,
                          ),
                          ),
                        ),
                        SizedBox(height: size.height*0.015,),
                        Padding(
                          padding: EdgeInsets.only(left: size.width*0.03),
                          child: Text("Accompolished visits: 120",
                          style: GoogleFonts.lato(
                            fontSize:size.width*0.038,
                            color: AppColors.contentColorBlack,
                          ),
                          ),
                        ),
                        SizedBox(height: size.height*0.019,),
                        Center(
                          child: Text("Total visits: 120",
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            fontSize:size.width*0.04,
                            color: AppColors.contentColorBlack,
                          ),
                          ),
                        ),
                      ],
                    ),
                   ),
                )
                    // 
                  ],
                ),
                //
            SizedBox(height: size.height*0.018,), 
            ElevatedButton(
            onPressed: (){

            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width*0.22,
                vertical: size.height*0.028,
              ),
              child: Text('create a route plan'),
            ),
              style: ElevatedButton.styleFrom(
              primary: AppColors.contentColorPurple,  // Set button color to purple
            ),
          ),
              ],
            ),
    ),
       ],
      ),
    );
  }
}