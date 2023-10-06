import 'package:crm/Utils/AppColors.dart';
import 'package:crm/Widgets/HomeScreenWIdgets/ContainerDisplayingMenuItems.dart';
import 'package:crm/Widgets/HomeScreenWIdgets/ContainerDisplayingStats.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
                                  // first dasbboard container with dashboard, drawer and userprofile icon
                      Container(
                        height: size.height*0.10,
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
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:EdgeInsets.only(left: size.width*0.02),
                                child: Icon(Icons.menu,
                                size: size.width*0.12,
                                color: AppColors.contentColorPurple,
                                ),
                              ),
                              Text("Dashboard", style: GoogleFonts.lato(
                                fontSize: size.width*0.062, 
                                fontWeight: FontWeight.bold
                              ),),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: size.width*0.03,
                                    ),
                                    child: Lottie.asset(
                                    'assets/json/notification.json', // Path to your Lottie animation JSON file
                                    width: size.width*0.20, // Adjust width as needed
                                    height: size.height*0.14,  
                                    fit: BoxFit.fill,
                                      ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: size.width*0.03,
                                    ),
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage("assets/images/userprofile.png"),
                                    radius: size.width*0.08,),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
            Stack(
              children: [
                // 
                Positioned.fill(
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.05), // Adjust opacity here
                      BlendMode.dstATop,
                    ),
                    child: Image.asset(
                      'assets/images/image1.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // 
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // container displaying statistics 
                      SizedBox(height: size.height*0.02,),
                      ContainerDisplayingStats(),
                      // Container displaying dashboard menu items
                      SizedBox(height: size.height*0.02,),
                      Container(
                        height: size.height*0.458,
                        width: double.maxFinite,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: ContainerDisplayingMenuItems()),
                      )
                      
                  
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}