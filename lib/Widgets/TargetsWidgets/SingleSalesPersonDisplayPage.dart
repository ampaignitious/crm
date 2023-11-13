import 'package:valour/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class SingleSalesPersonDisplayPage extends StatefulWidget {
  String? salesPersonName;
  String? salesPersonId;
   SingleSalesPersonDisplayPage({super.key, this.salesPersonId, this.salesPersonName});

  @override
  State<SingleSalesPersonDisplayPage> createState() => _SingleSalesPersonDisplayPageState(this.salesPersonId, this.salesPersonName);
}

class _SingleSalesPersonDisplayPageState extends State<SingleSalesPersonDisplayPage> {
  String? salesPersonName;
  String? salesPersonId;
  TextEditingController _startDate = TextEditingController();
  TextEditingController _endDate = TextEditingController();
   _SingleSalesPersonDisplayPageState(this.salesPersonId, this.salesPersonName);
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
          padding: EdgeInsets.only(left: size.width*0.09),
          child: Text("Target assignment page",
           style: GoogleFonts.lato(
            fontSize: size.width*0.05, 
            color: AppColors.menuBackground,
            fontWeight: FontWeight.bold
          ),),
        ),
      ),
      body: Container(
        height: size.height*0.9,
        width: size.width*0.98,
        margin: EdgeInsets.only(left: size.width*0.01, top: size.height*0.004),
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
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: size.height*0.009,), 
            SizedBox(height: size.height*0.020,),
          Center(
            child: Container(
                      height: size.height*0.09,
                      width: size.width*0.95,
                      decoration: BoxDecoration(
                       color: AppColors.contentColorPurple,
                       borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(child: Text("Assign sale' s target to : ${salesPersonName} ", style: GoogleFonts.lato(
                        color: Colors.white
                      ),)),
              ),
          ),
          SizedBox(height: size.height*0.007,),
            Form(child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
              
                children: [
                    SizedBox(height: size.height*0.018,), 
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Number of visits to be made",
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
                    ),
                    SizedBox(height: size.height*0.018,), 
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                        child: TextFormField(
                               controller: _startDate,
                                 onTap: () => _selectDate(context, _startDate),
                                decoration: InputDecoration(
                                  labelText: 'Start date',
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
                    SizedBox(height: size.height*0.018,), 
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                        child: TextFormField(
                               controller: _endDate,
                                 onTap: () => _selectDate(context, _endDate),
                                decoration: InputDecoration(
                                  labelText: 'End date',
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
                    SizedBox(height: size.height*0.028,),
                    Center(
                          child: ElevatedButton(
                          onPressed: (){
                             
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width*0.26,
                              vertical: size.height*0.028,
                            ),
                            child: Text('submit',
                            style: GoogleFonts.lato(
                              color: AppColors.contentColorPurple,
                            ),),
                          ),
                            style: ElevatedButton.styleFrom(
                            primary: AppColors.contentColorYellow,  // Set button color to purple
                          ),
                          ),
                        )
              
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
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
}