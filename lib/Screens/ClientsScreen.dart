import 'package:aiDvantage/Screens/ProfileScreen.dart';
import 'package:aiDvantage/Utils/AppColors.dart';
import 'package:aiDvantage/Widgets/Drawer/DrawerItems.dart';
import 'package:aiDvantage/Widgets/VisitScreenWidgets/CreateVisitScreen.dart';
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
    final List<VisitData> visitDataList = [
    VisitData("1", "Ignitious", "Interested"),
    VisitData("2", "Ampa", "Maybe"),
    VisitData("3", "Rakhi", "Interested"),
    VisitData("4", "Yash", "Maybe"),
    VisitData("300", "Pragati", "Interested"),
    VisitData("300", "Pragati", "Interested"),
    VisitData("300", "Pragati", "Maybe"),
    VisitData("300", "Pragati", "Maybe"),
    VisitData("300", "Pragati", "Interested"),
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
 
      appBar: AppBar(
        iconTheme: IconThemeData(
        color: AppColors.contentColorPurple,
        size: size.width*0.08,
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
          SizedBox(height: size.height*0.01,),
          Padding(
            padding: EdgeInsets.only(left:size.width*0.03, right:size.width*0.03, top:size.width*0.03, bottom:size.width*0.010),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                filterVisitData(value);
              },
              decoration: InputDecoration(
                labelText: 'search client by name',
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
                    child: Center(child: Text("client's name", style: GoogleFonts.lato(
                    ),))),
                  Container(
                    margin: EdgeInsets.only(left: size.width*0.01),
                    height: size.height*0.06,
                    width: size.width*0.3,
                    decoration: BoxDecoration(
                      color: AppColors.contentColorPurple,
                    ),
                    child: Center(child: Text("Status", style: GoogleFonts.lato(
                      color:Colors.white
                    ),)))
                ],
              ),
            ),
          ),
          Container(
            height: size.height*0.62,
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
          return CreateVisitScreen();
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