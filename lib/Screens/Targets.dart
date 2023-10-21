import 'package:crm/Models/VisitData.dart';
import 'package:crm/Utils/AppColors.dart';
import 'package:crm/Widgets/TargetsWidgets/SingleSalesPersonDisplayPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Targets extends StatefulWidget {
  const Targets({super.key});

  @override
  State<Targets> createState() => _TargetsState();
}

class _TargetsState extends State<Targets> {
  final List<VisitData> visitDataList = [
    VisitData("1", "Mohit", "pending"),
    VisitData("2", "Ankit", "pending"),
    VisitData("3", "Rakhi", "Archieved"),
    VisitData("4", "Yash", "pending"),
    VisitData("300", "Pragati", "Archieved"),
    VisitData("300", "Pragati", "Pending"),
    VisitData("300", "Pragati", "Pending"),
    VisitData("300", "Pragati", "Archieved"),
    VisitData("300", "Pragati", "Archieved"),
  ];
    late List<VisitData> filteredVisitDataList;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredVisitDataList = List.from(visitDataList);
  }

  void filterVisitData(String query) {
    setState(() {
      filteredVisitDataList = visitDataList
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
        elevation: 0.6,
        backgroundColor: AppColors.contentColorCyan,
 
        title: Padding(
          padding: EdgeInsets.only(left: size.width*0.09),
          child: Text("Targets page",
           style: GoogleFonts.lato(
            fontSize: size.width*0.05, 
            color: AppColors.menuBackground,
            fontWeight: FontWeight.bold
          ),),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            // 
            SizedBox(height: size.height*0.01,),
             Center(
               child: Container(
                height: size.height*0.24,
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
                
                  children: [
                    Row(
                      children: [
                       Lottie.asset(
                      'assets/json/target.json', // Path to your Lottie animation JSON file
                      width: size.width*0.43, // Adjust width as needed
                      height: size.height*0.15,  
                      fit: BoxFit.fill,
                        ),
                        // this container displays stats on the add a visit container display section
                      Container(
                      margin: EdgeInsets.only(top: size.height*0.02),
                      height: size.height*0.19,
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
                              child: Text("Targets summary report",
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
                              child: Text("sales people with pending targets: 100",
                              style: GoogleFonts.lato(
                                fontSize:size.width*0.03,
                                color: AppColors.contentColorBlack,
                              ),
                              ),
                            ),
                            SizedBox(height: size.height*0.015,),
                            Padding(
                              padding: EdgeInsets.only(left: size.width*0.02),
                              child: Text("Salesperson with completed targets: 30",
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
            //
            Column(
          children: [
            SizedBox(height: size.height*0.01,),
            Padding(
              padding: EdgeInsets.only(left:size.width*0.03, right:size.width*0.03, top:size.width*0.03, bottom:size.width*0.010),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  filterVisitData(value);
                },
                decoration: InputDecoration(
                  labelText: "search by name",
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
            Padding(
              padding: EdgeInsets.only(top:size.width*0.01, bottom:size.width*0.03),
              child: Text("Select and assign a sales's person a target", style: GoogleFonts.lato(
                color: Colors.black.withOpacity(0.2)
              ),),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width*0.01),
              height: size.height*0.06,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: AppColors.contentColorPurple
              ),
              child: Center(
                child: Row(
                  
                  children: [
                    Container(
                      height: size.height*0.06,
                      width: size.width*0.18,
                      decoration: BoxDecoration(
                        color: AppColors.contentColorWhite
                      ),
                      child: Center(child: Text("Id", style: GoogleFonts.lato(
          
                      ),))),
                    Container(
                      // margin: EdgeInsets.only(left: size.width*0.01),
                      height: size.height*0.06,
                      width: size.width*0.5,
                      decoration: BoxDecoration(
                        color: AppColors.contentColorYellow,
                      ),
                      child: Center(child: Text("sales person name", style: GoogleFonts.lato(
                      ),))),
                    Container(
                      margin: EdgeInsets.only(left: size.width*0.01),
                      height: size.height*0.06,
                      width: size.width*0.2,
                      decoration: BoxDecoration(
                        color: AppColors.contentColorPurple,
                      ),
                      child: Center(child: Text("Target status", style: GoogleFonts.lato(
                        fontSize: size.width*0.03,
                        color:Colors.white
                      ),)))
                  ],
                ),
              ),
            ),
            Container(
              height: size.height*0.52,
              width: double.maxFinite,
              child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: filteredVisitDataList.length,  // Use filtered data list here
              itemBuilder: (BuildContext context, int index) {
                final VisitData visitData = filteredVisitDataList[index];  // Use filtered data list here
                return buildTableRowWidget(visitData, spacing, spacing2, idwidth, idheight, visitwidth, descriptionwidth);
              },
                      ),
            ),
          ],
        ),
          
            // 
          ],
        ),
      ),
    );
  }
    Widget buildTableRowWidget(VisitData visitData, double size1, double size2, double idwidth, double idheight, double visitwidth, double descriptionwidth) {
    return InkWell(
      onTap: (){
       Navigator.push(context, MaterialPageRoute(builder: (context){
        return SingleSalesPersonDisplayPage(salesPersonId: visitData.id, salesPersonName: visitData.name,);
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
 
                    ),
                    child: Center(child: Text("${visitData.id}", style: GoogleFonts.lato(
                    ),),),
              ),
              Container(
                     height: idheight,
                    width: visitwidth,
                    decoration: BoxDecoration(
                      // color: AppColors.contentColorYellow,
                    ),
                    child: Center(child: Text("${visitData.name}", style: GoogleFonts.lato(
              ),))),
              Container(
                    height: idheight,
                    width: descriptionwidth,
                    decoration: BoxDecoration(
                      // color: AppColors.contentColorPurple,
                    ),
                    child: Center(child: Text("${visitData.description}", style: GoogleFonts.lato(
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
}
