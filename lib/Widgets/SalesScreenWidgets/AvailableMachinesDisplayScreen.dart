import 'package:crm/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class AvailableMachineDisplayScreen extends StatefulWidget {
  const AvailableMachineDisplayScreen({super.key});

  @override
  State<AvailableMachineDisplayScreen> createState() => _AvailableMachineDisplayScreenState();
}

class _AvailableMachineDisplayScreenState extends State<AvailableMachineDisplayScreen> with TickerProviderStateMixin{
  @override
      late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
        color: AppColors.contentColorPurple,
        size: size.width*0.08,
        ),  // Change the icon color here
        elevation: 0.6,
        backgroundColor: AppColors.contentColorCyan,
 
        title: Padding(
          padding: EdgeInsets.only(left: size.width*0.06),
          child: Text("Machines page",
           style: GoogleFonts.lato(
            fontSize: size.width*0.05, 
            color: AppColors.menuBackground,
            fontWeight: FontWeight.bold
          ),),
        ),
        actions: [
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
        ],
       bottom: TabBar(
          indicatorColor: AppColors.contentColorPurple.withOpacity(0),
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
                  child: Text("Total machines available: 210", style: GoogleFonts.lato(
                    fontSize: size.height*0.014,
                    color: AppColors.darkRoast
                  ),),
                ),
              ]),
            ),
          ]
       )
    ),
    body: Column(
      children: [
        Padding(
            padding: EdgeInsets.only(left:size.width*0.03, right:size.width*0.03, top:size.width*0.03, bottom:size.width*0.010),
            child: TextField(
              // controller: searchController,
              onChanged: (value) {
                // filterVisitData(value);
              },
              decoration: InputDecoration(
                labelText: 'Search the machine by name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: AppColors.contentColorPurple), // Change the border color here
                ),
              ),
            ),
          ),
        Container(
          height: size.height*0.7,
          width: double.maxFinite,
          child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 5,  // Use filtered data list here
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        SizedBox(height: size.height*0.02,),
                  Center(
                  child: Container(
                        height: size.height*0.25,
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
                      ],
                    );
                    },
              ),
        ),
      ],
    ),
    );
  }
}