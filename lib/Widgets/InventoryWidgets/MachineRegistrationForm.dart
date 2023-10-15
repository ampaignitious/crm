import 'package:crm/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MachineRegistrationScreen extends StatefulWidget {
  const MachineRegistrationScreen({super.key});

  @override
  State<MachineRegistrationScreen> createState() => _MachineRegistrationScreenState();
}

class _MachineRegistrationScreenState extends State<MachineRegistrationScreen> {
  @override
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
          padding: EdgeInsets.only(left: size.width*0.06),
          child: Text("Machine registration page",
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
            SizedBox(height: size.height*0.009,), 
            Padding(
              padding: EdgeInsets.only(left: size.width*0.03),
              child: Text("Enter the product details", style: GoogleFonts.lato(
                fontSize: size.width*0.045,
                color: Colors.black.withOpacity(0.5)
              ),),
            ),
            Form(child: Column(
              children: [
                 SizedBox(height: size.height*0.018,), 
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Enter product name",
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
                      decoration: InputDecoration(
                        labelText: "Product price",
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
                      decoration: InputDecoration(
                        labelText: "Product quantity",
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
                      decoration: InputDecoration(
                        labelText: "product description",
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
                          child: Text('register a machine',
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
            ))
          ],
        ),
      ),
    );
  }
}