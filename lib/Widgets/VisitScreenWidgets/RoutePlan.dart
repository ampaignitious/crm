import 'package:valour/Screens/NotificationScreen.dart';
import 'package:valour/Screens/ProfileScreen.dart';
import 'package:valour/Utils/AppColors.dart';
import 'package:valour/Widgets/Drawer/DrawerItems.dart';
import 'package:valour/Widgets/VisitScreenWidgets/RoutePlanHome.dart';
import 'package:valour/Widgets/VisitScreenWidgets/ViewRoutePlans.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class RoutePlan extends StatefulWidget {
  const RoutePlan({super.key});

  @override
  State<RoutePlan> createState() => _RoutePlanState();
}

class _RoutePlanState extends State<RoutePlan> with TickerProviderStateMixin{
    late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer:Drawer(
        backgroundColor: AppColors.contentColorPurple,
        width: size.width*0.8,
        child: const DrawerItems(),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(
        color: AppColors.contentColorPurple,
        size: size.width*0.11,
        ),  // Change the icon color here
        elevation: 0.6,
        backgroundColor: AppColors.contentColorCyan,
 
        title: Padding(
          padding: EdgeInsets.only(left: size.width*0.09),
          child: Text("Route Plans",
           style: GoogleFonts.lato(
            fontSize: size.width*0.055, 
            color: AppColors.menuBackground,
            fontWeight: FontWeight.bold
          ),),
        ),
        actions: [
          Row(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return const NotificationScreen();
                    }));
                  },
                  child: Padding(
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
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return const ProfileScreen();
                    }));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: size.width*0.03,
                    ),
                    child: CircleAvatar(
                      backgroundImage: const AssetImage("assets/images/userprofile.png"),
                    radius: size.width*0.065,),
                  ),
                )
              ],
            ),
        ],
        bottom: TabBar(
          indicatorColor: AppColors.contentColorPurple,
          controller: _tabController,
          tabs: [
            Tab(
              child: Row(children: [
                Icon(Icons.event_sharp,
                size:size.height*0.014,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: size.width*0.008
                  ),
                  child: Text("Home", style: GoogleFonts.lato(
                    fontSize: size.height*0.0135,
                    color: AppColors.darkRoast
                  ),),
                ),
              ]),
            ),
            
            Tab(
              child: Row(children: [
                Icon(Icons.event_seat,
                size:size.height*0.014,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: size.width*0.008
                  ),
                  child: Text("view route plans", style: GoogleFonts.lato(
                    fontSize: size.height*0.013,
                     color: AppColors.darkRoast
                  ),),
                ),
              ]),
            ),
          ],
        ),
      ),
      
     body: TabBarView(
        controller: _tabController,
        children: const [
          RoutePlanHome(),
          ViewRoutePlans(),
        ],
      ),
    );
  }
}