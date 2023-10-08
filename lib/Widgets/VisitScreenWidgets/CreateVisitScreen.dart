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
    String? _selectedOption = '';
    String? _selectedVisitPurpose='Demo';
  List<String> _visitPurposes = ['Demo', 'Sale', 'Maintenance'];
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
                      // radio buttons
                  Column(
                    children: <Widget>[
                      RadioListTile(
                        title: Text(
                          'Interested',
                          style: GoogleFonts.lato(
                            fontSize: size.width * 0.04,
                          ),
                        ),
                        value: 'Interested',
                        groupValue: _selectedOption, // This is crucial for radio button selection
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value as String?;
                          });
                        },
                        activeColor: AppColors.contentColorPurple,
                      ),
                      RadioListTile(
                        title: Text(
                          'Maybe',
                          style: GoogleFonts.lato(
                            fontSize: size.width * 0.04,
                          ),
                        ),
                        value: 'Maybe',
                        groupValue: _selectedOption, // This is crucial for radio button selection
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value as String?;
                          });
                        },
                        activeColor: AppColors.contentColorPurple,
                      ),
                      RadioListTile(
                        title: Text(
                          'Not',
                          style: GoogleFonts.lato(
                            fontSize: size.width * 0.04,
                          ),
                        ),
                        value: 'Not',
                        groupValue: _selectedOption, // This is crucial for radio button selection
                        onChanged: (value) {
                          setState(() {
                            _selectedOption = value as String?;
                          });
                        },
                        activeColor: AppColors.contentColorPurple,
                      ),
                    ],
                  ),

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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Visit purpose",style: GoogleFonts.lato(
                                  color: AppColors.contentColorWhite
                                ),
                              ),
                        DropdownButton<String>(
                          iconEnabledColor: Colors.white,
                      value: _selectedVisitPurpose,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedVisitPurpose = newValue;
                        });
                      },
                      items: _visitPurposes.asMap().entries.map((entry) {
                      int index = entry.key;
                      String purpose = entry.value;
                      return DropdownMenuItem<String>(
                        value: purpose,
                        child: Text(
                          purpose,
                          style: index == 0
                              ? TextStyle(color: Color.fromARGB(255, 255, 252, 69))  // Change the color for the first item
                              : null,  // Use default style for other items
                        ),
                      );
                    }).toList(),
                    ),
                            ],
                          ),
                        ),
                      ),
                      //
                      SizedBox(height: size.height*0.025,), 
                      Center(
                        child: ElevatedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return CreateVisitScreen();
                          }));
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width*0.26,
                            vertical: size.height*0.028,
                          ),
                          child: Text('record a visit',
                          style: GoogleFonts.lato(
                            color: AppColors.contentColorPurple,
                          ),),
                        ),
                          style: ElevatedButton.styleFrom(
                          primary: AppColors.contentColorYellow,  // Set button color to purple
                        ),
                        ),
                      ),
                      SizedBox(height: size.height*0.035,),
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