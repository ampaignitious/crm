import 'package:crm/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ContainerDisplayingMenuItems extends StatefulWidget {
  const ContainerDisplayingMenuItems({super.key});

  @override
  State<ContainerDisplayingMenuItems> createState() => _ContainerDisplayingMenuItemsState();
}

class _ContainerDisplayingMenuItemsState extends State<ContainerDisplayingMenuItems> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // first row
      Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                height: size.height*0.10,
                width: size.width*0.45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                          color: AppColors.contentColorPurple.withOpacity(0.3)
                        ),
                  boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: Offset(0.8, 1.0),
                          blurRadius: 4.0,
                          spreadRadius: 0.2,
                        ),
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: Offset(-0.8, -1.0),
                          blurRadius: 4.0,
                          spreadRadius: 0.2,
                        ),
                      ],
                ),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height:size.height*0.10 ,
                      width: size.width*0.18,
                      decoration: BoxDecoration(
                        color: AppColors.contentColorCyan,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.contentColorPurple
                        )
                       ),
                       child: Center(
                        child: Lottie.asset(
                        'assets/json/visits.json', // Path to your Lottie animation JSON file
                        width: size.width*0.14, // Adjust width as needed
                        height: size.height*0.16,  
                        fit: BoxFit.fill,
                          ),
                       ),
                    ),
                    Text("Visits", style: GoogleFonts.lato(
                      fontSize: size.width*0.04,
                    ),)
                  ],
                ),
            ),
            // 
            // first row element two
             Container(
                height: size.height*0.10,
                width: size.width*0.45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                          color: AppColors.contentColorGreen.withOpacity(0.3)
                        ),
                  boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: Offset(0.8, 1.0),
                          blurRadius: 4.0,
                          spreadRadius: 0.2,
                        ),
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: Offset(-0.8, -1.0),
                          blurRadius: 4.0,
                          spreadRadius: 0.2,
                        ),
                      ],
                ),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Clients", style: GoogleFonts.lato(
                      fontSize: size.width*0.04,
                    ),),
                    Container(
                      height:size.height*0.10 ,
                      width: size.width*0.18,
                      decoration: BoxDecoration(
                        color: AppColors.contentColorCyan,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.contentColorGreen
                        )
                       ),
                       child: Center(
                        child: Lottie.asset(
                        'assets/json/client.json', // Path to your Lottie animation JSON file
                        width: size.width*0.14, // Adjust width as needed
                        height: size.height*0.16,  
                        fit: BoxFit.fill,
                          ),
                       ),
                    ),
                  ],
                ),
            ),
            
          ],
        ),
      ),
      // 
      SizedBox(height: size.height*0.03,),
      // Second row
      Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                height: size.height*0.10,
                width: size.width*0.45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                          color: AppColors.contentColorYellow.withOpacity(0.3)
                        ),
                  boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: Offset(0.8, 1.0),
                          blurRadius: 4.0,
                          spreadRadius: 0.2,
                        ),
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: Offset(-0.8, -1.0),
                          blurRadius: 4.0,
                          spreadRadius: 0.2,
                        ),
                      ],
                ),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height:size.height*0.10 ,
                      width: size.width*0.18,
                      decoration: BoxDecoration(
                        color: AppColors.contentColorCyan,
                        shape: BoxShape.circle,
                       ),
                       child: Center(
                        child: Lottie.asset(
                        'assets/json/sales.json', // Path to your Lottie animation JSON file
                        width: size.width*0.14, // Adjust width as needed
                        height: size.height*0.16,  
                        fit: BoxFit.fill,
                          ),
                       ),
                    ),
                    Text("Sales", style: GoogleFonts.lato(
                      fontSize: size.width*0.04,
                    ),)
                  ],
                ),
            ),
            // 
            // second row element two
             Container(
                height: size.height*0.10,
                width: size.width*0.45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                          color: AppColors.darkRoast.withOpacity(0.3)
                        ),
                  boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: Offset(0.8, 1.0),
                          blurRadius: 4.0,
                          spreadRadius: 0.2,
                        ),
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: Offset(-0.8, -1.0),
                          blurRadius: 4.0,
                          spreadRadius: 0.2,
                        ),
                      ],
                ),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Mainteance", style: GoogleFonts.lato(
                      fontSize: size.width*0.04,
                    ),),
                    Container(
                      height:size.height*0.10,
                      width: size.width*0.18,
                      decoration: BoxDecoration(
                        color: AppColors.contentColorCyan,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.contentColorGreen
                        )
                       ),
                       child: Center(
                        child: Lottie.asset(
                        'assets/json/mainteance.json', // Path to your Lottie animation JSON file
                        width: size.width*0.18, // Adjust width as needed
                        height: size.height*0.16,  
                        fit: BoxFit.fill,
                          ),
                       ),
                    ),
                  ],
                ),
            ),
            
          ],
        ),
      ),
      //
      SizedBox(height: size.height*0.03,),
      // third row
      Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                height: size.height*0.10,
                width: size.width*0.45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                          color: AppColors.contentColorPink.withOpacity(0.3)
                        ),
                  boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: Offset(0.8, 1.0),
                          blurRadius: 4.0,
                          spreadRadius: 0.2,
                        ),
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: Offset(-0.8, -1.0),
                          blurRadius: 4.0,
                          spreadRadius: 0.2,
                        ),
                      ],
                ),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height:size.height*0.17 ,
                      width: size.width*0.19,
                      decoration: BoxDecoration(
                        color: AppColors.contentColorCyan,
                        shape: BoxShape.circle,
                       ),
                       child: Center(
                        child: Lottie.asset(
                        'assets/json/target.json', // Path to your Lottie animation JSON file
                        width: size.width*0.17, // Adjust width as needed
                        height: size.height*0.05,  
                        fit: BoxFit.fill,
                          ),
                       ),
                    ),
                    Text("Targets", style: GoogleFonts.lato(
                      fontSize: size.width*0.04,
                    ),)
                  ],
                ),
            ),
            // 
            // Third row element two
             Container(
                height: size.height*0.10,
                width: size.width*0.45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                          color: AppColors.contentColorOrange.withOpacity(0.3)
                        ),
                  boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: Offset(0.8, 1.0),
                          blurRadius: 4.0,
                          spreadRadius: 0.2,
                        ),
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: Offset(-0.8, -1.0),
                          blurRadius: 4.0,
                          spreadRadius: 0.2,
                        ),
                      ],
                ),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Notifications", style: GoogleFonts.lato(
                      fontSize: size.width*0.04,
                    ),),
                    Container(
                      height:size.height*0.10,
                      width: size.width*0.18,
                      decoration: BoxDecoration(
                        color: AppColors.contentColorCyan,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.contentColorOrange
                        )
                       ),
                       child: Center(
                        child: Lottie.asset(
                        'assets/json/notification.json', // Path to your Lottie animation JSON file
                        width: size.width*0.18, // Adjust width as needed
                        height: size.height*0.16,  
                        fit: BoxFit.fill,
                          ),
                       ),
                    ),
                  ],
                ),
            ),
            
          ],
        ),
      ),
      //
      // four row
      SizedBox(height: size.height*0.03,),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                height: size.height*0.10,
                width: size.width*0.45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                          color: AppColors.gridLinesColor.withOpacity(0.3)
                        ),
                  boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: Offset(0.8, 1.0),
                          blurRadius: 4.0,
                          spreadRadius: 0.2,
                        ),
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: Offset(-0.8, -1.0),
                          blurRadius: 4.0,
                          spreadRadius: 0.2,
                        ),
                      ],
                ),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height:size.height*0.17 ,
                      width: size.width*0.19,
                      decoration: BoxDecoration(
                        color: AppColors.contentColorCyan,
                        shape: BoxShape.circle,
                       ),
                       child: Center(
                        child: Lottie.asset(
                        'assets/json/login2.json', // Path to your Lottie animation JSON file
                        width: size.width*0.22, // Adjust width as needed
                        height: size.height*0.85,  
                        fit: BoxFit.fill,
                          ),
                       ),
                    ),
                    Text("Account settings", style: GoogleFonts.lato(
                      fontSize: size.width*0.025,
                    ),
                     
                    )
                  ],
                ),
            ),
            // 
            // Third row element two
             Container(
                height: size.height*0.10,
                width: size.width*0.45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                          color: AppColors.mainTextColor2.withOpacity(0.3)
                        ),
                  boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: Offset(0.8, 1.0),
                          blurRadius: 4.0,
                          spreadRadius: 0.2,
                        ),
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: Offset(-0.8, -1.0),
                          blurRadius: 4.0,
                          spreadRadius: 0.2,
                        ),
                      ],
                ),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Feedback", style: GoogleFonts.lato(
                      fontSize: size.width*0.04,
                    ),),
                    Container(
                      height:size.height*0.10,
                      width: size.width*0.18,
                      decoration: BoxDecoration(
                        color: AppColors.contentColorCyan,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.mainTextColor2
                        )
                       ),
                       child: Center(
                        child: Lottie.asset(
                        'assets/json/feedback.json', // Path to your Lottie animation JSON file
                        width: size.width*0.18, // Adjust width as needed
                        height: size.height*0.16,  
                        fit: BoxFit.fill,
                          ),
                       ),
                    ),
                  ],
                ),
            ),
            
          ],
        ),
      ),
      
    
    ],
    );
  }
}