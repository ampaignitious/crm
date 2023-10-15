import 'package:crm/Utils/AppColors.dart';
import 'package:crm/Widgets/Drawer/DrawerItems.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
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
          child: Text("Clients screen",
           style: GoogleFonts.lato(
            fontSize: size.width*0.05, 
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
    
    );
  }
}