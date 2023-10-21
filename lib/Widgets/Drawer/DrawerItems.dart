import 'package:crm/Screens/AuthenticationSceens/LoginScreen.dart';
import 'package:crm/Screens/ClientsScreen.dart';
import 'package:crm/Screens/DefaultScreen.dart';
import 'package:crm/Screens/MainteanceScreen.dart';
import 'package:crm/Screens/SalesScreen.dart';
import 'package:crm/Screens/Targets.dart';
import 'package:crm/Screens/VisitsPage.dart';
import 'package:crm/Utils/AppColors.dart';
import 'package:flutter/material.dart';
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
  width: size.width * 0.8,
  child: Drawer(
    child: ListView(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue, // Adjust the background color of the drawer header
          ), child: null,
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