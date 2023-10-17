import 'package:crm/Screens/ProfileScreen.dart';
import 'package:crm/Utils/AppColors.dart';
import 'package:crm/Widgets/Drawer/DrawerItems.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class MainteanceScreen extends StatefulWidget {
  const MainteanceScreen({super.key});

  @override
  State<MainteanceScreen> createState() => _MainteanceScreenState();
}

class _MainteanceScreenState extends State<MainteanceScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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

        backgroundColor: AppColors.contentColorCyan,
 
        title: Text("Mainteance page",
         style: GoogleFonts.lato(
          fontSize: size.width*0.05, 
          color: AppColors.menuBackground,
          fontWeight: FontWeight.bold
        ),),
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
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return ProfileScreen();
                    }));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: size.width*0.03,
                    ),
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/userprofile.png"),
                    radius: size.width*0.065,),
                  ),
                )
              ],
            ),
        ],
      ),
      body: Column(
        children: [
         SizedBox(height: size.height*0.016,),
          // 
          Center(
            child: Container(
              height: size.height*0.38,
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
              height: size.height*0.38,
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
        ],
      ),
    );
  }
}