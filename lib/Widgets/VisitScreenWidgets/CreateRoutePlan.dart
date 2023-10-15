import 'package:crm/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class CreateRoutePlan extends StatefulWidget {
  const CreateRoutePlan({super.key});

  @override
  State<CreateRoutePlan> createState() => _CreateRoutePlanState();
}

class _CreateRoutePlanState extends State<CreateRoutePlan> {
  @override
  Widget build(BuildContext context) {
    final size =MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.contentColorCyan,
        iconTheme: IconThemeData(
        color: AppColors.contentColorPurple,
        size: size.width*0.08,
        ),
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.only(left: size.width*0.06),
          child: Text("route management page",
           style: GoogleFonts.lato(
            fontSize: size.width*0.052, 
            color: AppColors.contentColorPurple,
            fontWeight: FontWeight.bold
          ),),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: size.height*0.28,
            width:double.maxFinite,
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
                        // borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left:size.width*0.03),
                  child: Row(
                    children: [
                      Padding(
                        padding:EdgeInsets.only(right: size.width*0.03),
                        child: Icon(Icons.location_on, color: Colors.red,),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Current location", style: GoogleFonts.lato(
                            color:AppColors.darkRoast,
                            fontWeight: FontWeight.bold,
                            fontSize:size.width*0.03
                          ),),
                          Text("Acacia mall, 14-18 Copper Rd, Kampala", style: GoogleFonts.lato(
                            color:AppColors.contentColorPurple,
                            fontWeight: FontWeight.bold,
                            fontSize:size.width*0.03
                          ),),
                        ],
                      )
                    ],
                  ),
                ),
                Divider(),
                Center(child: Text("Summary route plan statistics", style: GoogleFonts.lato(
                  fontSize: size.width*0.04
                ),)),
                SizedBox(height: size.height*0.012,),
                Card(
                  color: AppColors.contentColorBlue.withOpacity(0.3),
                  margin: EdgeInsets.symmetric(horizontal: size.width*0.03),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: size.width*0.06),
                        child: Lottie.asset(
                                'assets/json/completed.json', // Path to your Lottie animation JSON file
                                width: size.width*0.13, // Adjust width as needed
                                height: size.height*0.08,  
                                fit: BoxFit.fill,
                          ),
                      ),
                        Padding(
                          padding: EdgeInsets.only(left: size.width*0.12),
                          child: Text("Completed road plans:", style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: size.width*0.04,
                          ),),
                        ),
                        Padding(
                           padding: EdgeInsets.only(left: size.width*0.01),
                          child: Text("234", style: GoogleFonts.lato(
                            color: AppColors.contentColorPurple
                          ),),
                        )
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height*0.01,
                ),
                Card(
                  color: AppColors.contentColorBlue.withOpacity(0.3),
                  margin: EdgeInsets.symmetric(horizontal: size.width*0.03),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: size.width*0.06),
                        child: Lottie.asset(
                                'assets/json/pending.json', // Path to your Lottie animation JSON file
                                width: size.width*0.15, // Adjust width as needed
                                height: size.height*0.09,  
                                fit: BoxFit.fill,
                          ),
                      ),
                        Padding(
                          padding: EdgeInsets.only(left: size.width*0.12),
                          child: Text("Pending road plans:", style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            color:Colors.white,
                            fontSize: size.width*0.04,
                          ),),
                        ),
                        Padding(
                           padding: EdgeInsets.only(left: size.width*0.01),
                          child: Text("234", style: GoogleFonts.lato(
                            color: AppColors.contentColorPurple
                          ),),
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
                  height: size.height*0.01,
                ),
          Center(
            child: Container(
            height: size.height*0.58,
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
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left:size.width*0.03, top: size.height*0.006),
                    child: Text("Create a route plan", style: GoogleFonts.lato(
                    color: AppColors.contentColorPurple.withOpacity(0.4),
                    ),),
                  ),
                    Divider(
                      thickness: 1,
                    ),
                    // the form field 
                 SizedBox(height: size.height*0.015,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                    child: TextFormField(
                             decoration: InputDecoration(
                               labelText: 'Route name',
                               border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(20),
                               ),
                           enabledBorder: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(20),
                                 borderSide: BorderSide(color: AppColors.contentColorPurple), // Change the border color here
                               ),
                       // controller: _endDate,
                            ),
                    ),
                  ),
                  SizedBox(height: size.height*0.015,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                    child: TextFormField(
                             decoration: InputDecoration(
                               labelText: 'Description about the route',
                               border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(20),
                               ),
                           enabledBorder: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(20),
                                 borderSide: BorderSide(color: AppColors.contentColorPurple), // Change the border color here
                               ),
                       // controller: _endDate,
                            ),
                    ),
                  ),
                  // 
                  SizedBox(height: size.height*0.020,),
                       Padding(
                         padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                         child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'Enter start location',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(color: AppColors.contentColorPurple), // Change the border color here
                                    ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: size.width*0.03),
                              height: size.height*0.08,
                              width: size.width*0.14,
                              decoration: BoxDecoration(
                                color:AppColors.contentColorCyan,
                                boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              offset: Offset(0.8, 1.0),
                              blurRadius: 4.0,
                              spreadRadius: 0.2,
                            ),
                                ],
                            border: Border.all(
                              color: AppColors.contentColorPurple.withOpacity(0.2)
                            ),
                            borderRadius: BorderRadius.circular(10)
                              ),
                              child: Icon(Icons.location_on, color: AppColors.contentColorPurple)),
                          ],
                                           ),
                       ),
                      //  
                      // 
                  SizedBox(height: size.height*0.020,),
                       Padding(
                         padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                         child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'Enter destination location',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(color: AppColors.contentColorPurple), // Change the border color here
                                    ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: size.width*0.03),
                              height: size.height*0.08,
                              width: size.width*0.14,
                              decoration: BoxDecoration(
                                color:AppColors.contentColorCyan,
                                boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              offset: Offset(0.8, 1.0),
                              blurRadius: 4.0,
                              spreadRadius: 0.2,
                            ),
                                ],
                            border: Border.all(
                              color: AppColors.contentColorPurple.withOpacity(0.2)
                            ),
                            borderRadius: BorderRadius.circular(10)
                              ),
                              child: Icon(Icons.location_on, color: AppColors.contentColorPurple)),
                          ],
                                           ),
                       ),
                      //  
                      // 
                  SizedBox(height: size.height*0.020,),
                       Padding(
                         padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                         child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'start date',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(color: AppColors.contentColorPurple), // Change the border color here
                                    ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: size.width*0.03),
                              height: size.height*0.08,
                              width: size.width*0.14,
                              decoration: BoxDecoration(
                                color:AppColors.contentColorCyan,
                                boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              offset: Offset(0.8, 1.0),
                              blurRadius: 4.0,
                              spreadRadius: 0.2,
                            ),
                                ],
                            border: Border.all(
                              color: AppColors.contentColorPurple.withOpacity(0.2)
                            ),
                            borderRadius: BorderRadius.circular(10)
                              ),
                              child: Icon(Icons.date_range, color: AppColors.contentColorPurple)),
                          ],
                                           ),
                       ),
                      // 
                          // 
                  SizedBox(height: size.height*0.020,),
                       Padding(
                         padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                         child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'end date',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(color: AppColors.contentColorPurple), // Change the border color here
                                    ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: size.width*0.03),
                              height: size.height*0.08,
                              width: size.width*0.14,
                              decoration: BoxDecoration(
                                color:AppColors.contentColorCyan,
                                boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              offset: Offset(0.8, 1.0),
                              blurRadius: 4.0,
                              spreadRadius: 0.2,
                            ),
                                ],
                            border: Border.all(
                              color: AppColors.contentColorPurple.withOpacity(0.2)
                            ),
                            borderRadius: BorderRadius.circular(10)
                              ),
                              child: Icon(Icons.date_range, color: AppColors.contentColorPurple)),
                          ],
                                           ),
                       ),
                      // 
                      SizedBox(height: size.height*0.020,),
                        Center(
                          child: ElevatedButton(
                          onPressed: (){
                            // Navigator.push(context, MaterialPageRoute(builder: (context){
                            //   // return CreateVisitScreen();
                            // }));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width*0.26,
                              vertical: size.height*0.028,
                            ),
                            child: Text('register route plan',
                            style: GoogleFonts.lato(
                              color: AppColors.contentColorPurple,
                            ),),
                          ),
                            style: ElevatedButton.styleFrom(
                            primary: AppColors.contentColorYellow,  // Set button color to purple
                          ),
                          ),
                        ),
                        SizedBox(height: size.height*0.025,), 
                ],
              ),
            )
                 ),
          )
          
        ],
      ),
    );
  }
}