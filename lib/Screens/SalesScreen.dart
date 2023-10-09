import 'package:crm/Utils/AppColors.dart';
import 'package:crm/Widgets/Drawer/DrawerItems.dart';
import 'package:crm/Widgets/SalesScreenWidgets/AvailableCoffeeProductsDisplayScreen.dart';
import 'package:crm/Widgets/SalesScreenWidgets/AvailableMachinesDisplayScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer:Drawer(
        backgroundColor: AppColors.contentColorPurple,
        width: size.width*0.8,
        child: DrawerItems(),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(
        color: AppColors.contentColorPurple,
        size: size.width*0.11,
        ),  // Change the icon color here
        elevation: 0.6,
        backgroundColor: AppColors.contentColorCyan,
 
        title: Padding(
          padding: EdgeInsets.only(left: size.width*0.06),
          child: Text("sales page",
           style: GoogleFonts.lato(
            fontSize: size.width*0.062, 
            color: AppColors.menuBackground,
            fontWeight: FontWeight.bold
          ),),
        ),
        actions: [
          Row(
              children: [
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
                Padding(
                  padding: EdgeInsets.only(
                    right: size.width*0.03,
                  ),
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/userprofile.png"),
                  radius: size.width*0.065,),
                )
              ],
            ),
        ],
    ),
    body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height*0.008,),
          Center(
            child: Container(
              height: size.height*0.18,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                     Padding(
                  padding: EdgeInsets.only(top: size.height*0.012),
                   child: Lottie.asset(
                                   'assets/json/sales.json', // Path to your Lottie animation JSON file
                                   width: size.width*0.33, // Adjust width as needed
                                   height: size.height*0.16,  
                                   fit: BoxFit.fill,
                    ),
                  ),
                  // this container displays stats on the add a visit container display section
                   Container(
                    height: size.height*0.15,
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
                        child: Text("sales summary",
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
                        child: Text("Total coffee machines sold: 456",
                        style: GoogleFonts.lato(
                          fontSize:size.width*0.03,
                          color: AppColors.contentColorBlack,
                        ),
                        ),
                      ),
                      SizedBox(height: size.height*0.015,),
                      Padding(
                        padding: EdgeInsets.only(left: size.width*0.03),
                        child: Text("Total coffee products sold: 120",
                        style: GoogleFonts.lato(
                          fontSize:size.width*0.030,
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
                  
                ],
              ),
            ),
          ),
          SizedBox(height: size.height*0.016,),
          // 
          Center(
            child: Container(
              height: size.height*0.18,
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
             ),
          ),
          // 
          SizedBox(height: size.height*0.016,),
          // 
          Center(
            child: Container(
              height: size.height*0.18,
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
             ),
          ),
          //
          SizedBox(height: size.height*0.028,),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return AvailableMachineDisplayScreen();
              }));
            },
            child: Center(
              child: Container(
                        height: size.height*0.09,
                        width: size.width*0.95,
                        decoration: BoxDecoration(
                         color: AppColors.contentColorPurple,
                         borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(child: Text("Check available machines", style: GoogleFonts.lato(
                          color: Colors.white
                        ),)),
                ),
            ),
          ),
          SizedBox(height: size.height*0.020,),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return AvailableCoffeeProductsDisplayScreen();
              }));
            },
            child: Center(
              child: Container(
                        height: size.height*0.09,
                        width: size.width*0.95,
                        decoration: BoxDecoration(
                         color: AppColors.contentColorPurple,
                         borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(child: Text("Check available coffee products", style: GoogleFonts.lato(
                          color: Colors.white
                        ),)),
                ),
            ),
          ),
          SizedBox(height: size.height*0.020,),
          Center(
            child: Container(
                      height: size.height*0.09,
                      width: size.width*0.95,
                      decoration: BoxDecoration(
                       color: AppColors.contentColorPurple,
                       borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(child: Text("fill sales complicate", style: GoogleFonts.lato(
                        color: Colors.white
                      ),)),
              ),
          ),
          // 
          SizedBox(height: size.height*0.020,),
          
          
          // 
        ],
      ),
    ),
    );
  }
}