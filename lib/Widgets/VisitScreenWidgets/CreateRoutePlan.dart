import 'package:valour/Controllers/services.dart';
import 'package:valour/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

class CreateRoutePlan extends StatefulWidget {
  const CreateRoutePlan({super.key});

  @override
  State<CreateRoutePlan> createState() => _CreateRoutePlanState();
}

class _CreateRoutePlanState extends State<CreateRoutePlan> {
  TextEditingController routeName = TextEditingController();
  TextEditingController routeDescription = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  TextEditingController startLocation = TextEditingController();
  TextEditingController endLocation = TextEditingController();
  Location location = Location();

  @override
  void initState() {
    super.initState();
  }

  Future<void> submitForm() async {
    Map<String, dynamic> body = {
      "route_name": routeName.text,
      "route_description": routeDescription.text,
      "start_location": startLocation.text,
      "end_location": endLocation.text,
      "route_start_date": startDate.text,
      "route_end_date": endDate.text,
    };

    AuthController authController = AuthController();
    final response = await authController.addRoutePlan(body);

    if (response['status'] == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response['message']),
          backgroundColor: Colors.green,
        ),
      );

      //clear the text fields
      routeName.clear();
      routeDescription.clear();
      startDate.clear();
      endDate.clear();
      startLocation.clear();
      endLocation.clear();
      
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response['error']),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.contentColorCyan,
        iconTheme: IconThemeData(
          color: AppColors.contentColorPurple,
          size: size.width * 0.08,
        ),
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.only(left: size.width * 0.06),
          child: Text(
            "Add Route Plan",
            style: GoogleFonts.lato(
                fontSize: size.width * 0.052,
                color: AppColors.contentColorPurple,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            SizedBox(
              height: size.height * 0.01,
            ),
            Center(
              child: Container(
                  width: size.width * 0.95,
                  decoration: BoxDecoration(
                    color: AppColors.contentColorCyan,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: const Offset(0.8, 1.0),
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
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: size.width * 0.03, top: size.height * 0.006),
                          child: Text(
                            "Create a route plan",
                            style: GoogleFonts.lato(
                              color:
                                  AppColors.contentColorPurple.withOpacity(0.4),
                            ),
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        // the form field
                        SizedBox(
                          height: size.height * 0.015,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: size.width * 0.03),
                          child: TextFormField(
                            controller: routeName,
                            decoration: InputDecoration(
                              labelText: 'Route name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: AppColors
                                        .contentColorPurple), // Change the border color here
                              ),
                              // controller: _endDate,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.015,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: size.width * 0.03),
                          child: TextFormField(
                            controller: routeDescription,
                            maxLines: 7, // Set the maximum number of lines
                            minLines: 5,
                            decoration: InputDecoration(
                              labelText: 'Description about the route',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: AppColors
                                        .contentColorPurple), // Change the border color here
                              ),
                              // controller: _endDate,
                            ),
                          ),
                        ),
                        //
                        SizedBox(
                          height: size.height * 0.020,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: size.width * 0.03),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: startLocation,
                                  decoration: InputDecoration(
                                    labelText: 'Enter start location',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          color: AppColors
                                              .contentColorPurple), // Change the border color here
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                  margin:
                                      EdgeInsets.only(left: size.width * 0.03),
                                  height: size.height * 0.08,
                                  width: size.width * 0.14,
                                  decoration: BoxDecoration(
                                      color: AppColors.contentColorCyan,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          offset: const Offset(0.8, 1.0),
                                          blurRadius: 4.0,
                                          spreadRadius: 0.2,
                                        ),
                                      ],
                                      border: Border.all(
                                          color: AppColors.contentColorPurple
                                              .withOpacity(0.2)),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Icon(Icons.location_on,
                                      color: AppColors.contentColorPurple)),
                            ],
                          ),
                        ),
                        //
                        //
                        SizedBox(
                          height: size.height * 0.020,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: size.width * 0.03),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: endLocation,
                                  decoration: InputDecoration(
                                    labelText: 'Enter destination location',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          color: AppColors
                                              .contentColorPurple), // Change the border color here
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                  margin:
                                      EdgeInsets.only(left: size.width * 0.03),
                                  height: size.height * 0.08,
                                  width: size.width * 0.14,
                                  decoration: BoxDecoration(
                                      color: AppColors.contentColorCyan,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          offset: const Offset(0.8, 1.0),
                                          blurRadius: 4.0,
                                          spreadRadius: 0.2,
                                        ),
                                      ],
                                      border: Border.all(
                                          color: AppColors.contentColorPurple
                                              .withOpacity(0.2)),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Icon(Icons.location_on,
                                      color: AppColors.contentColorPurple)),
                            ],
                          ),
                        ),
                        //
                        //
                        SizedBox(
                          height: size.height * 0.020,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: size.width * 0.03),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: startDate,
                                  onTap: () => _selectDate(context, startDate),
                                  decoration: InputDecoration(
                                    labelText: 'start date',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          color: AppColors
                                              .contentColorPurple), // Change the border color here
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                  margin:
                                      EdgeInsets.only(left: size.width * 0.03),
                                  height: size.height * 0.08,
                                  width: size.width * 0.14,
                                  decoration: BoxDecoration(
                                      color: AppColors.contentColorCyan,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          offset: const Offset(0.8, 1.0),
                                          blurRadius: 4.0,
                                          spreadRadius: 0.2,
                                        ),
                                      ],
                                      border: Border.all(
                                          color: AppColors.contentColorPurple
                                              .withOpacity(0.2)),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Icon(Icons.date_range,
                                      color: AppColors.contentColorPurple)),
                            ],
                          ),
                        ),
                        //
                        //
                        SizedBox(
                          height: size.height * 0.020,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: size.width * 0.03),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: endDate,
                                  onTap: () => _selectDate(context, endDate),
                                  decoration: InputDecoration(
                                    labelText: 'end date',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          color: AppColors
                                              .contentColorPurple), // Change the border color here
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                  margin:
                                      EdgeInsets.only(left: size.width * 0.03),
                                  height: size.height * 0.08,
                                  width: size.width * 0.14,
                                  decoration: BoxDecoration(
                                      color: AppColors.contentColorCyan,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          offset: const Offset(0.8, 1.0),
                                          blurRadius: 4.0,
                                          spreadRadius: 0.2,
                                        ),
                                      ],
                                      border: Border.all(
                                          color: AppColors.contentColorPurple
                                              .withOpacity(0.2)),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Icon(Icons.date_range,
                                      color: AppColors.contentColorPurple)),
                            ],
                          ),
                        ),
                        //
                        SizedBox(
                          height: size.height * 0.020,
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              submitForm();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors
                                  .contentColorYellow, // Set button color to purple
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.26,
                                vertical: size.height * 0.028,
                              ),
                              child: Text(
                                'Add route plan',
                                style: GoogleFonts.lato(
                                  color: AppColors.contentColorPurple,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.025,
                        ),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  //

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      // Update the selected date in the text field
      final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      controller.text = formattedDate;
    }
  }
  //
}
