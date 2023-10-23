import 'package:crm/Screens/AuthenticationSceens/LoginScreen.dart';
import 'package:crm/Screens/ClientsScreen.dart';
import 'package:crm/Screens/DefaultScreen.dart';
import 'package:crm/Screens/MainteanceScreen.dart';
import 'package:crm/Screens/ProfileScreen.dart';
import 'package:crm/Screens/SalesScreen.dart';
import 'package:crm/Screens/Targets.dart';
import 'package:crm/Screens/VisitsPage.dart';
import 'package:crm/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class DrawerItems extends StatefulWidget {
  const DrawerItems({super.key});

  @override
  State<DrawerItems> createState() => _DrawerItemsState();
}

class _DrawerItemsState extends State<DrawerItems> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
  return Drawer(
  width: size.width * 0.9,
  child: Drawer(
    child: ListView(
      children: [
        DrawerHeader(
          margin: EdgeInsets.symmetric(horizontal: size.width*0.01),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.contentColorPurple.withOpacity(0.2)
            ),
            borderRadius: BorderRadius.circular(10),
            color: AppColors.contentColorCyan, // Adjust the background color of the drawer header
          ), child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return ProfileScreen();
                        }));
                      },
                      child: CircleAvatar(
                        radius: size.width*0.08,
                        backgroundImage: AssetImage("assets/images/userimage.jpg"),
                      ),
                    ),
                    Text("Alex mugisha", style: GoogleFonts.lato(
                      fontSize: size.width*0.04,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),),
                  ],
                ),
                
                SizedBox(height: size.height*0.012,),
                Row(
                  children: [
                    Icon(Icons.email,
                    color: AppColors.contentColorPurple,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: size.width*0.03),
                      child: Text("alexmugisha@gmail.com"),
                    )
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    Icon(Icons.phone,
                    color: AppColors.contentColorPurple,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: size.width*0.03),
                      child: Text("07846740604"),
                    )
                  ],
                ),
                  
              ],
            ),
          ),
          // ... other header content ...
        ),
        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return DefaultScreen();
            }));
          },
          child: Card(
            child: ListTile(
              leading: Icon(
                  Icons.home,
                  color: AppColors.contentColorPurple, // Change the color of the drawer icon here
                ),
              title: Text('Home'),
             
            ),
          ),
        ),
        // 
        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return VisitsPage();
            }));
          },
          child: Card(
            child: ListTile(
              leading: Icon(
                  Icons.location_on,
                  color: AppColors.contentColorPurple, // Change the color of the drawer icon here
                ),
              title: Text('Route plan'),
         
            ),
          ),
        ),
        // 
        Card(
          child: ListTile(
            leading: Lottie.asset(
                          'assets/json/visits.json', // Path to your Lottie animation JSON file
                          width: size.width*0.14, // Adjust width as needed
                          height: size.height*0.16,  
                          fit: BoxFit.fill,
                            ),
            title: Text('Visits'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return VisitsPage();
              }));
            },
          ),
        ),
        // 
        Card(
          child: ListTile(
            leading: Lottie.asset(
                        'assets/json/client.json', // Path to your Lottie animation JSON file
                        width: size.width*0.14, // Adjust width as needed
                        height: size.height*0.16,  
                        fit: BoxFit.fill,
                          ),
            title: Text('Clients'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return ClientsScreen();
              }));
            },
          ),
        ),
        // 
        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return SalesScreen();
            }));
          },
          child: Card(
            child: ListTile(
              leading: Lottie.asset(
                          'assets/json/sales.json', // Path to your Lottie animation JSON file
                          width: size.width*0.14, // Adjust width as needed
                          height: size.height*0.16,  
                          fit: BoxFit.fill,
                            ),
              title: Text('Sales'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return SalesScreen();
                }));
              },
            ),
          ),
        ),
        // 
        Card(
          child: ListTile(
            leading: Lottie.asset(
                        'assets/json/target.json', // Path to your Lottie animation JSON file
                        width: size.width*0.17, // Adjust width as needed
                        height: size.height*0.05,  
                        fit: BoxFit.fill,
                          ),
            title: Text('Targets'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return Targets();
              }));
            },
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(
                Icons.settings,
                color: AppColors.contentColorPurple, // Change the color of the drawer icon here
              ),
            title: Text('Mainteanance'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return MainteanceScreen();
              }));
            },
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(
                Icons.exit_to_app_rounded,
                color: AppColors.contentColorPurple, // Change the color of the drawer icon here
              ),
            title: Text('Logout'),
            onTap: () {
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
              return LoginScreen();
             }));
            },
          ),
        ),
      ],
    ),
  ),
);

  }
}