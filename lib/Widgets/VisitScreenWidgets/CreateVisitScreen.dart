import 'package:crm/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateVisitScreen extends StatefulWidget {
  const CreateVisitScreen({super.key});

  @override
  State<CreateVisitScreen> createState() => _CreateVisitScreenState();
}

class _CreateVisitScreenState extends State<CreateVisitScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.contentColorCyan,
        iconTheme: IconThemeData(
        color: AppColors.contentColorPurple,
        size: size.width*0.11,
        ),
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.only(left: size.width*0.06),
          child: Text("visit registration page",
           style: GoogleFonts.lato(
            fontSize: size.width*0.062, 
            color: AppColors.contentColorPurple,
            fontWeight: FontWeight.bold
          ),),
        ),
      ),
      body: Stack(
      children: [
        Container(
          height: size.height*0.29,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)
            ),
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
          )
        ),
        Container(
          margin: EdgeInsets.only(top: size.height*0.02, left: size.width*0.03),
          height: size.height*0.85,
          width: size.width*0.95,
          decoration: BoxDecoration(
            border: Border.all(
                color: AppColors.contentColorPurple.withOpacity(0.2)
              ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight:Radius.circular(15),
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
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
                         BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          offset: Offset(0.8, 1.0),
                          blurRadius: 4.0,
                          spreadRadius: 0.2,
                        ),
                      ],
          ),
          child: 
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height*0.015,),
                  Center(
                    child: Text("complete the form below", style: GoogleFonts.lato(
                    color: AppColors.contentColorPurple.withOpacity(0.4),
                    ),),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  // the form field 
               Padding(
                 padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                 child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                    SizedBox(height: size.height*0.015,),
                     TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Enter business name',
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
                      SizedBox(height: size.height*0.020,),
                     Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Enter business location',
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
                    // 
                      SizedBox(height: size.height*0.020,),
                    TextFormField(
                              decoration: InputDecoration(
                                labelText: "Enter contact person's name",
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
                      SizedBox(height: size.height*0.022,),
                      // contact display promt container
                      Container(
                          margin: EdgeInsets.only(left: size.width*0.008),
                          height: size.height*0.07,
                          width: size.width*0.92,
                          decoration: BoxDecoration(
                            color:AppColors.contentColorPurple,
                            boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          offset: Offset(0.8, 1.0),
                          blurRadius: 4.0,
                          spreadRadius: 0.2,
                        ),
                            ]
                          ),
                        child: Center(
                          child: Text(
                            "Contacts",style: GoogleFonts.lato(
                              color: AppColors.contentColorWhite
                            ),
                          ),
                        ),
                      ),
                      //
                      SizedBox(height: size.height*0.010,), 
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Enter contact person's name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: AppColors.contentColorPurple), // Change the border color here
                          ),
                        // controller: _endDate,
                             ),
                      ),
                      SizedBox(height: size.height*0.010,), 
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Enter contact person's name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: AppColors.contentColorPurple), // Change the border color here
                          ),
                        // controller: _endDate,
                             ),
                      ),
                      // SizedBox(height: size.height*0.020,),
                      // 
                      SizedBox(height: size.height*0.022,),
                      // contact display promt container
                      Container(
                          margin: EdgeInsets.only(left: size.width*0.008),
                          height: size.height*0.07,
                          width: size.width*0.92,
                          decoration: BoxDecoration(
                            color:AppColors.contentColorPurple,
                            boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          offset: Offset(0.8, 1.0),
                          blurRadius: 4.0,
                          spreadRadius: 0.2,
                        ),
                            ]
                          ),
                        child: Center(
                          child: Text(
                            "Buying status",style: GoogleFonts.lato(
                              color: AppColors.contentColorWhite
                            ),
                          ),
                        ),
                      ),
                      // 
                   ],
                 ),
               )
          
                  // 
                ],
              ),
            ),
          ),
        )
      ],),
    );
  }
}