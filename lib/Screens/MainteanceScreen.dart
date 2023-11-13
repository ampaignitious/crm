import 'package:valour/Models/Mainteanance.dart';
import 'package:valour/Utils/AppColors.dart';
import 'package:valour/Widgets/MainteananceWidgets/SingleMainteananceDisplayScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class MainteanceScreen extends StatefulWidget {
  const MainteanceScreen({super.key});

  @override
  State<MainteanceScreen> createState() => _MainteanceScreenState();
}

class _MainteanceScreenState extends State<MainteanceScreen> {
  final List<MainteananceData> visitDataList = [
  MainteananceData("1", "update", "Working on updating the system to improve performance and add new features."),
  MainteananceData("2", "repair", "Issue was identified and is currently being repaired to ensure the system's functionality."),
  MainteananceData("3", "repair", "Fixing and resolving various issues to ensure the system operates smoothly."),
  MainteananceData("4", "power", "Working on enhancing the power management features to optimize energy consumption."),
  MainteananceData("300", "Pragati", "Working on resolving issues and improving system performance."),
  MainteananceData("300", "update", "Working on updates and enhancements to provide a better user experience."),
  MainteananceData("300", "Pragati", "Addressing issues and making improvements for optimal functionality."),
  MainteananceData("300", "Pragati", "Issue was identified, and we are working on resolving it."),
  MainteananceData("300", "Pragati", "Showing interest and dedication to the project's success."),
];
    late List<MainteananceData> filteredMainteananceDataList;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredMainteananceDataList = List.from(visitDataList);
  }

  void filterMainteananceData(String query) {
    setState(() {
      filteredMainteananceDataList = visitDataList
          .where((visitData) =>
              visitData.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
     var spacing =size.width*0.14;
    var spacing2 =size.width*0.03;
    //
    var idwidth =size.width*0.18;
    var idheight =size.height*0.06;
    var visitwidth = size.width*0.48;
    var descriptionwidth=size.width*0.3;
    return Scaffold(
       
      appBar: AppBar(
        iconTheme: IconThemeData(
        color: AppColors.contentColorPurple,
        size: size.width*0.08,
        ),  // Change the icon color here

        backgroundColor: AppColors.contentColorCyan,
 
        title: Padding(
          padding: EdgeInsets.only(left: size.width*0.03),
          child: Text("Machine Maintenance",
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
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           SizedBox(height: size.height*0.016,),
            // 
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: size.height*0.015 ),
                      child: Center(
                        child: Text("Mainteanance Status", style: GoogleFonts.lato(
                          fontSize:size.width*0.050,
                          color: AppColors.contentColorPurple,
                          fontWeight: FontWeight.bold
                        ),),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Lottie.asset(
                          'assets/json/mainteance.json', // Path to your Lottie animation JSON file
                          width: size.width*0.32, // Adjust width as needed
                          height: size.height*0.18,  
                          fit: BoxFit.fill,
                      ),
                    Container(
                      height: size.height*0.15,
                      width: size.width*0.008,
                      decoration: BoxDecoration(
                        color: Colors.black
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // defects
                    Padding(
                      padding: EdgeInsets.only(top: size.height*0.015, left: size.width*0.04),
                      child: Text("Defected machines: 89", style: GoogleFonts.lato(
                        fontSize: size.width*0.03
                      ),),
                    ),
                    // 
                    Divider(),
                    // Upcoming
                    Padding(
                      padding: EdgeInsets.only(top: size.height*0.015, left: size.width*0.04),
                      child: Text("Upcoming mainteanances: 23", style: GoogleFonts.lato(
                 fontSize: size.width*0.03
                      ),),
                    ),
                    //
                    Divider(),
                    //// Completed
                    Padding(
                      padding: EdgeInsets.only(top: size.height*0.015, left: size.width*0.04),
                      child: Text("Completed mainteanances: 182", style: GoogleFonts.lato(
                     fontSize: size.width*0.03
                      ),),
                    ),
                    //  
                          ],
                        )
                      ],
                    )
                
                  ],
                ),
               ),
            ),
            // 
            SizedBox(height: size.height*0.016,),
            Padding(
              padding: EdgeInsets.only(left:size.width*0.03),
              child: Text("Mainteanance reccords", style: GoogleFonts.lato(
              color: AppColors.coffeeBean,
              fontWeight: FontWeight.bold,
              fontSize: size.width*0.04
              ),),
            ),
            // 
            Padding(
              padding: EdgeInsets.only(left:size.width*0.03, right:size.width*0.03, top:size.width*0.03, bottom:size.width*0.010),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  filterMainteananceData(value);
                },
                decoration: InputDecoration(
                  labelText: 'search a mainteanance record',
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
            SizedBox(height: size.height*0.016,),
            // display list section
              Container(
              height: size.height*0.06,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: AppColors.gridLinesColor
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width*0.006),
                  child: Row(
                    
                    children: [
                      Container(
                        height: size.height*0.06,
                        width: size.width*0.18,
                        decoration: BoxDecoration(
                          color: AppColors.contentColorPurple
                        ),
                        child: Center(child: Text("Id", style: GoogleFonts.lato(
                       color: Colors.white
                        ),))),
                      Container(
                        // margin: EdgeInsets.only(left: size.width*0.01),
                        height: size.height*0.06,
                        width: size.width*0.5,
                        decoration: BoxDecoration(
                          color: AppColors.contentColorYellow,
                        ),
                        child: Center(child: Text("Mainteanance purpose", style: GoogleFonts.lato(
                        ),))),
                      Container(
                        margin: EdgeInsets.only(left: size.width*0.01),
                        height: size.height*0.06,
                        width: size.width*0.28,
                        decoration: BoxDecoration(
                          color: AppColors.contentColorBlack,
                        ),
                        child: Center(child: Text("details", style: GoogleFonts.lato(
                          color:Colors.white
                        ),)))
                    ],
                  ),
                ),
              ),
                      ),
            Container(
              height: size.height*0.62,
              width: double.maxFinite,
              child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: filteredMainteananceDataList.length,  // Use filtered data list here
              itemBuilder: (BuildContext context, int index) {
                final MainteananceData singleData = filteredMainteananceDataList[index];  // Use filtered data list here
                return buildTableRowWidget(singleData, spacing, spacing2, idwidth, idheight, visitwidth, descriptionwidth);
              },
                      ),
            ),
          
            // 
          ],
        ),
      ),
    );
  }
  // 
    Widget buildTableRowWidget(MainteananceData singleData, double size1, double size2, double idwidth, double idheight, double visitwidth, double descriptionwidth) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return SingleMainteananceDisplayScreen(mainteanancePurpose: singleData.name, mainteananceDetails: singleData.description,);
        }));
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical:size2),
          child: Row(
             children: [
               Container(
                     height: idheight,
                    width: idwidth,
                    decoration: BoxDecoration(
                      // color: AppColors.contentColorWhite,
                    ),
                    child: Center(child: Text("${singleData.id}", style: GoogleFonts.lato(
                    ),),),
              ),
              Container(
                     height: idheight,
                    width: visitwidth,
                    decoration: BoxDecoration(
                      // color: AppColors.contentColorYellow,
                    ),
                    child: Center(child: Text("${singleData.name}", style: GoogleFonts.lato(
              ),))),
              Container(
                    height: idheight,
                    width: descriptionwidth,
                    decoration: BoxDecoration(
                      // color: AppColors.contentColorPurple,
                    ),
                    child: Center(child: Text("${singleData.description}", style: GoogleFonts.lato(
                      color:Colors.black
                    ),
                    textAlign: TextAlign.center,
                    )))
            ],
          ),
        ),
      ),
    );
  }
  // 
}
