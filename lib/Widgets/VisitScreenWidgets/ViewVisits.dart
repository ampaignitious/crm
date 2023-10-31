 import 'package:aiDvantage/Utils/AppColors.dart';
import 'package:aiDvantage/Widgets/VisitScreenWidgets/SIngleVisitViewScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewVisits extends StatefulWidget {
  const ViewVisits({super.key});

  @override
  State<ViewVisits> createState() => _ViewVisitsState();
}

class _ViewVisitsState extends State<ViewVisits> {
  final List<VisitData> visitDataList = [
    VisitData("1", "Mohit", "working for the best"),
    VisitData("2", "Ankit", "working for the best"),
    VisitData("3", "Rakhi", "working for the best"),
    VisitData("4", "Yash", "working for the best"),
    VisitData("300", "Pragati", "working for the best"),
    VisitData("300", "Pragati", "working for the best"),
    VisitData("300", "Pragati", "working for the best"),
    VisitData("300", "Pragati", "working for the best"),
    VisitData("300", "Pragati", "working for the best"),
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
      resizeToAvoidBottomInset: false,
      body: Column(
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
                labelText: 'Search by visit name',
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
            child: Text("Click on the item to see more information", style: GoogleFonts.lato(
              color: Colors.black.withOpacity(0.2)
            ),),
          ),
          Container(
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
                    child: Center(child: Text("visit name", style: GoogleFonts.lato(
                    ),))),
                  Container(
                    margin: EdgeInsets.only(left: size.width*0.01),
                    height: size.height*0.06,
                    width: size.width*0.3,
                    decoration: BoxDecoration(
                      color: AppColors.contentColorPurple,
                    ),
                    child: Center(child: Text("Description", style: GoogleFonts.lato(
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
    );
  }
  Widget buildTableRowWidget(VisitData visitData, double size1, double size2, double idwidth, double idheight, double visitwidth, double descriptionwidth) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
        return SingleVisitViewScreen(visitName: visitData.name, visitDescription: visitData.description,);
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
class VisitData {
  final String id;
  final String name;
  final String description;

  VisitData(this.id, this.name, this.description);
} 