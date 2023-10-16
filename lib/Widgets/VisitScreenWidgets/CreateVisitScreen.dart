import 'package:crm/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateVisitScreen extends StatefulWidget {
  const CreateVisitScreen({super.key});

  @override
  State<CreateVisitScreen> createState() => _CreateVisitScreenState();
}

class _CreateVisitScreenState extends State<CreateVisitScreen> {
  bool mainteance =false;
  bool demo= false;
  bool delivery = false;
  bool appointment = false;
  bool sales = false;
  Widget build(BuildContext context) {
 
    final size = MediaQuery.of(context).size;
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
          child: Text("visit registration page",
           style: GoogleFonts.lato(
            fontSize: size.width*0.058, 
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
              child: Form(
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
                    Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 
                                      //  pitch interest container
                          Container(
                  margin: EdgeInsets.only(left: size.width*0.008),
                  height: size.height*0.08,
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
                    "Visit purpose",style: GoogleFonts.lato(
                      color: AppColors.contentColorWhite
                    ),
                  ),
                ),
                          ),
              SizedBox(height: size.height*0.008,),
              // showing interest status
              Padding(
                padding: EdgeInsets.only(left:size.width*0.03),
                child: Text("Select one visit purpose to capture its additional details", style: GoogleFonts.lato(
                  fontSize:size.width*0.028,
                  color: AppColors.contentColorPurple.withOpacity(0.4),
                ),),
              ),
              SizedBox(height: size.height*0.015,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Mainteance
                  Column(
                    children: [
                      InkWell(
                        onTap: (){
                          setState(() {
                            demo=false;
                            mainteance=!mainteance;
                            delivery = false;
                            appointment = false;
                            sales = false;
                          });
                        },
                        child: Container(
                          height: size.height*0.03,
                          width: size.width*0.06,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                             border: Border.all(
                              color: AppColors.contentColorPurple
                             )
                          ),
                          child: Center(child: Icon(Icons.task_alt_rounded,
                          size: size.width*0.045,
                          color: mainteance==true?AppColors.contentColorPurple:Colors.white,
                          )),
                        ),
                      ),
                      Text("Mainteance", style: GoogleFonts.lato(
                        fontSize:size.width*0.03
                      ),)
                    ],
                  ),
                  // 
                  // Demo
                  Column(
                    children: [
                      InkWell(
                        onTap:(){
                          setState(() {
                            demo=!demo;
                            mainteance=false;
                            delivery = false;
                            appointment = false;
                            sales = false;
                          });
                        },
                        child: Container(
                          height: size.height*0.03,
                          width: size.width*0.06,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                             border: Border.all(
                              color: AppColors.contentColorPurple,
                             )
                          ),
                          child: Center(child: Icon(Icons.task_alt_rounded,
                          size: size.width*0.045,
                          color: demo==true?AppColors.contentColorPurple:Colors.white,
                          ))
                        ),
                      ),
                      Text("Demo", style: GoogleFonts.lato(
                        fontSize:size.width*0.03
                      ),)
                    ],
                  ),
                  // 
                  // Delivery
                  Column(
                    children: [
                      Container(
                        height: size.height*0.03,
                        width: size.width*0.06,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                           border: Border.all(
                            color: AppColors.contentColorPurple
                           )
                        ),
                        child: InkWell(
                          onTap:(){
                          setState(() {
                            demo=false;
                            mainteance=false;
                            appointment = false;
                            sales = false;
                            delivery = !delivery;
                          });
                        },
                          child: Center(child: Icon(Icons.task_alt_rounded,
                            size: size.width*0.045,
                            color: delivery==true?AppColors.contentColorPurple:Colors.white,
                            )),
                        ),
                      ),
                      Text("Delivery", style: GoogleFonts.lato(
                        fontSize:size.width*0.03
                      ),)
                    ],
                  ),
                  //
                  // Appointment
                  Column(
                    children: [
                      Container(
                        height: size.height*0.03,
                        width: size.width*0.06,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                           border: Border.all(
                            color: AppColors.contentColorPurple
                           )
                        ),
                        child: InkWell(
                          onTap:(){
                          setState(() {
                            demo=false;
                            mainteance=false;
                            delivery = false;
                            appointment = !appointment;
                            sales = false;
                          });
                        },
                          child: Center(child: Icon(Icons.task_alt_rounded,
                            size: size.width*0.045,
                            color: appointment==true?AppColors.contentColorPurple:Colors.white,
                            )),
                        ),
                      ),
                      Text("Appointment", style: GoogleFonts.lato(
                        fontSize:size.width*0.03
                      ),)
                    ],
                  ),
                  //
                  // sales
                  Column(
                    children: [
                      Container(
                        height: size.height*0.03,
                        width: size.width*0.06,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                           border: Border.all(
                            color: AppColors.contentColorPurple
                           )
                        ),
                        child: InkWell(
                          onTap:(){
                          setState(() {
                            demo=false;
                            mainteance=false;
                            delivery = false;
                            appointment = false;
                            sales = !sales;
                          });
                        },
                          child: Center(child: Icon(Icons.task_alt_rounded,
                            size: size.width*0.045,
                            color: sales==true?AppColors.contentColorPurple:Colors.white,
                            )),
                        ),
                      ),
                      Text("Sales", style: GoogleFonts.lato(
                        fontSize:size.width*0.03
                      ),)
                    ],
                  ),
                  //   
              
                ],
                  ),//end of the row that shows the visit purpose options
              // section to capture mainteance details
              mainteance==true?Container(
                margin: EdgeInsets.only(left: size.width*0.03, right: size.width*0.03,top: size.height*0.008),
                height: size.height*0.25,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  border:Border.all(
                    color: AppColors.contentColorPurple
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                    SizedBox(height: size.height*0.030,),
                    // capturing date of mainteance
                     Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                      child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Date of mainteance',
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
                    SizedBox(height: size.height*0.030,),
                    // capturing comment related to  mainteance
                     Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                      child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'mainteance comment',
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
                    // in this section we have to capture also various data ie to be captured inside the column
                     
                    // --- the above that to be sent to an api end point --- //
                    //
                    SizedBox(height: size.height*0.020,),
                    ],
                  ),
                ),
              ):Container(),
              // end section to capture mainteance details

              // section to capture demo input field on demo section
              demo==true?Container(
                margin: EdgeInsets.only(left: size.width*0.03, right: size.width*0.03,top: size.height*0.008),
                height: size.height*0.25,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  border:Border.all(
                    color: AppColors.contentColorPurple
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                    SizedBox(height: size.height*0.030,),
                    // capturing date of mainteance
                     Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                      child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Demo date',
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
                    SizedBox(height: size.height*0.030,),
                    // capturing comment related to  mainteance
                     Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                      child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Demo notes',
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
                    // in this section we have to capture also the 
                    // user id
                    //  business id
                    // visit id
                    // --- the above that to be sent to an api end point --- //
                    //
                    SizedBox(height: size.height*0.020,),
                    ],
                  ),
                ),
              ):Container(),
              // eend of section to capture demo input field on demo section

              // section to capture delivery input fields on delivery section
              delivery==true?Container(
                margin: EdgeInsets.only(left: size.width*0.03, right: size.width*0.03,top: size.height*0.008),
                height: size.height*0.25,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  border:Border.all(
                    color: AppColors.contentColorPurple
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                    SizedBox(height: size.height*0.030,),
                    // capturing date of mainteance
                     Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                      child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'product to be delivered',
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
                    SizedBox(height: size.height*0.030,),
                    // capturing comment related to  mainteance
                     Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                      child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Quantity',
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
                    // in this section we have to capture also the 
                    // user id
                    //  business id
                    // visit id
                    // --- the above that to be sent to an api end point --- //
                    //
                    SizedBox(height: size.height*0.020,),
                    ],
                  ),
                ),
              ):Container(),
              //  end of section to capture delivery input fields on delivery section
              // section to cpature appointment input fields on appointment section
              appointment==true?Container(
                margin: EdgeInsets.only(left: size.width*0.03, right: size.width*0.03,top: size.height*0.008),
                height: size.height*0.48,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  border:Border.all(
                    color: AppColors.contentColorPurple
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                    SizedBox(height: size.height*0.030,),
                    // capturing date of mainteance
                     Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                      child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Meeting date',
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
                    SizedBox(height: size.height*0.030,),
                    // capturing comment related to  mainteance
                     Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                      child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Meeting start time',
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
                    SizedBox(height: size.height*0.030,),
                    // capturing comment related to  mainteance
                     Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                      child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Meeting end time',
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
                    SizedBox(height: size.height*0.030,),
                    // capturing comment related to  mainteance
                     Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                      child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Meeting notes',
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
                    // in this section we have to capture also the 
                    // user id
                    //  business id
                    // visit id
                    // --- the above that to be sent to an api end point --- //
                    //
                    SizedBox(height: size.height*0.030,),
                    ],
                  ),
                ),
              ):Container(),
              //  end of section to capture appointment input fields on appointment section
              // section to capture sales input fields on sales section
              sales==true?Container(
                margin: EdgeInsets.only(left: size.width*0.03, right: size.width*0.03,top: size.height*0.008),
                height: size.height*0.25,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  border:Border.all(
                    color: AppColors.contentColorPurple
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                    SizedBox(height: size.height*0.030,),
                    // capturing date of mainteance
                     Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                      child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Product',
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
                    SizedBox(height: size.height*0.030,),
                    // capturing comment related to  mainteance
                     Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                      child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'quantity',
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
                    // in this section we have to capture also the 
                    // user id
                    //  business id
                    // visit id
                    // --- the above that to be sent to an api end point --- //
                    //
                    SizedBox(height: size.height*0.030,),
                    ],
                  ),
                ),
              ):Container(),
              
              // end of section to capture sales input fields on sales section
              SizedBox(height: size.height*0.020,),
                 Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                  child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'visit notes',
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
                    child: Text('Record a visit',
                    style: GoogleFonts.lato(
                      fontSize: size.width*0.035,
                      color: AppColors.contentColorPurple,
                    ),),
                  ),
                    style: ElevatedButton.styleFrom(
                    primary: AppColors.contentColorYellow,  // Set button color to purple
                  ),
                  ),
                ),
                SizedBox(height: size.height*0.025,),
                  // 
                      ],
                    ))
                    // 
                  ],
                ),
              ),
            ),
          ),
        )
      ],),
    );
  }
}