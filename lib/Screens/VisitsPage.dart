import 'package:crm/Utils/AppColors.dart';
import 'package:crm/Widgets/Drawer/DrawerItems.dart';
import 'package:crm/Widgets/VisitScreenWidgets/MenuOptions.dart';
import 'package:crm/Widgets/VisitScreenWidgets/ViewRoutePlans.dart';
import 'package:crm/Widgets/VisitScreenWidgets/ViewVisits.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class VisitsPage extends StatefulWidget {
  const VisitsPage({super.key});

  @override
  State<VisitsPage> createState() => _VisitsPageState();
}

class _VisitsPageState extends State<VisitsPage> with TickerProviderStateMixin{
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
          child: Text("visits page",
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
                  child: Text("menu options", style: GoogleFonts.lato(
                    fontSize: size.height*0.014,
                    color: AppColors.darkRoast
                  ),),
                ),
              ]),
            ),
            Tab(
              child: Row(children: [
                Icon(Icons.timeline,
                size:size.height*0.014,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: size.width*0.004
                  ),
                  child: Text("view visits", style: GoogleFonts.lato(
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
                    fontSize: size.height*0.014,
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
        children: [
          MenuOptions(),
          ViewVisits(),
          ViewRoutePlans(),
        ],
      ),
    );
  }
}


//  a class showing menu options and some statistics on them
