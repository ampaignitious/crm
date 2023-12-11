import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:valour/Controllers/services.dart';
import 'package:valour/Models/Appointment.dart';
import 'package:valour/Screens/appointments/AppointmentDetails.dart';
import 'package:valour/Utils/AppColors.dart';

class Appointment extends StatefulWidget {
  const Appointment({super.key});

  @override
  State<Appointment> createState() => AppointmentState();
}

class AppointmentState extends State<Appointment> {
  late Future<List<AppointmentData>> appointments;
    TextEditingController searchController = TextEditingController();


  @override
  void initState() {
    super.initState();
    appointments = getAppointments();
  }

  Future<List<AppointmentData>> getAppointments() async {
    AuthController authController = AuthController();
    try {
      final response = await authController.getAppointments();
      if (response.containsKey("error")) {
        throw Exception("The return is an error");
      } else {
        if (response['data'] != null) {
          List<dynamic> appointmentData = response['data'];
          List<AppointmentData> appointments = appointmentData.map((item) {
            return AppointmentData(
              id: item['id'],
              businessName: item['visit']['visit']['business_name'],
              meetingDate: item['meeting_date'],
              meetingStartTime: item['meeting_start_time'],
              meetingEndTime: item['meeting_end_time'],
              meetingNotes: item['meeting_notes'],
              visitNotes: item['visit']['visit_notes'],
            );
          }).toList();
          return appointments;
        } else {
          // Handle the case where the 'contacts' field in the API response is null
          throw Exception("No data found");
        }
      }
    } catch (error) {
      print("Error: $error");
      // Handle the case where the 'contacts' field in the API response is null
      throw Exception("Un expected error occurred");
    }
  }

 @override
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
          child: Text("Meetings",
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
                                offset: const Offset(0.8, 1.0),
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
                        child: Text("Appointment Status", style: GoogleFonts.lato(
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
                      child: Text("Upcoming Appointments: 23", style: GoogleFonts.lato(
                 fontSize: size.width*0.03
                      ),),
                    ),
                    //
                    Divider(),
                    //// Completed
                    Padding(
                      padding: EdgeInsets.only(top: size.height*0.015, left: size.width*0.04),
                      child: Text("Completed Appointments: 182", style: GoogleFonts.lato(
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
              child: Text("Appointment reccords", style: GoogleFonts.lato(
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
                },
                decoration: InputDecoration(
                  labelText: 'search a Appointment record',
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
                        child: Center(child: Text("Business Name", style: GoogleFonts.lato(
                        ),))),
                      Container(
                        margin: EdgeInsets.only(left: size.width*0.01),
                        height: size.height*0.06,
                        width: size.width*0.28,
                        decoration: BoxDecoration(
                          color: AppColors.contentColorBlack,
                        ),
                        child: Center(child: Text("Date", style: GoogleFonts.lato(
                          color:Colors.white
                        ),)))
                    ],
                  ),
                ),
              ),
                      ),
           FutureBuilder(
            future: appointments,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("An error occurred"),
                  );
                } else if (snapshot.hasData) {
                  final data = snapshot.data as List<AppointmentData>;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        for (var i = 0; i < data.length; i++)
                          buildTableRowWidget(data[i], spacing, spacing2, idwidth, idheight, visitwidth, descriptionwidth),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: Text("No data"),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          
            // 
          ],
        ),
      ),
    );
  }

  Widget buildTableRowWidget(AppointmentData appointmentData, double size1, double size2, double idwidth, double idheight, double visitwidth, double descriptionwidth) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
        return AppointmentDetails(appointment: appointmentData);
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
                    decoration: const BoxDecoration(
                      // color: AppColors.contentColorWhite,
                    ),
                    child: Center(child: Text("${appointmentData.id}", style: GoogleFonts.lato(
                    ),),),
              ),
              Container(
                     height: idheight,
                    width: visitwidth,
                    decoration: const BoxDecoration(
                      // color: AppColors.contentColorYellow,
                    ),
                    child: Center(child: Text(appointmentData.businessName, style: GoogleFonts.lato(
              ),))),
              Container(
                    height: idheight,
                    width: descriptionwidth,
                    decoration: const BoxDecoration(
                      // color: AppColors.contentColorPurple,
                    ),
                    child: Center(child: Text(appointmentData.meetingDate, style: GoogleFonts.lato(
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
