import 'package:crm/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductSalesForm extends StatefulWidget {
  const ProductSalesForm({super.key});

  @override
  State<ProductSalesForm> createState() => _ProductSalesFormState();
}

class _ProductSalesFormState extends State<ProductSalesForm> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height*0.020,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
            child: TextFormField(
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
          ),
          SizedBox(height: size.height*0.020,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
            child: TextFormField(
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
          ),
          SizedBox(height: size.height*0.020,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
            child: TextFormField(
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
          ),
          SizedBox(height: size.height*0.020,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
            child: TextFormField(
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
          ),
          SizedBox(height: size.height*0.020,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
            child: TextFormField(
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
          ),
          SizedBox(height: size.height*0.025,), 
          Center(
            child: ElevatedButton(
            onPressed: (){
              // Navigator.push(context, MaterialPageRoute(builder: (context){
              //   return CreateVisitScreen();
              // }));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width*0.26,
                vertical: size.height*0.028,
              ),
              child: Text('record a sale',
              style: GoogleFonts.lato(
                color: AppColors.contentColorPurple,
              ),),
            ),
              style: ElevatedButton.styleFrom(
              primary: AppColors.contentColorYellow,  // Set button color to purple
            ),
            ),
          ),
        ],
      ),
    );
  }
}