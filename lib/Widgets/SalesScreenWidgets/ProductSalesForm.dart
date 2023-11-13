import 'package:valour/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductSalesForm extends StatefulWidget {
  const ProductSalesForm({super.key});

  @override
  State<ProductSalesForm> createState() => _ProductSalesFormState();
}

class _ProductSalesFormState extends State<ProductSalesForm> {
    //texteditingcollectingcontroller for sales data
  List<TextEditingController> productMachineSalesControllers = [TextEditingController()];
  List<TextEditingController> productQuantityControllers = [TextEditingController()];

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: size.height*0.020,),
            Container(
                      margin: EdgeInsets.only(left: size.width*0.02, right: size.width*0.02,top: size.height*0.008),
                      height: size.height*0.65,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        border:Border.all(
                          color: AppColors.contentColorPurple
                        ),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: 
                        Column(
                          children: [
                     SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                       child: Column(
                                   children: [
                                   Column(
                        children: [
                        // row showing click to add input and the add button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left:size.width*0.09),
                              child: Text("Click to add more input field", style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold,
                                color: AppColors.contentColorPurple,
                                fontSize: size.width*0.04
                              ),),
                            ),
                             Container(
                              margin: EdgeInsets.only(right:size.width*0.04,
                              top: size.height*0.004,
                              ),
                                height: size.height*0.05,
                                width: size.width*0.09,
                                decoration: BoxDecoration(
                                   color:AppColors.contentColorPurple,
                                  shape: BoxShape.circle,
                                   border: Border.all(
                                    color: AppColors.contentColorPurple
                                   )
                                ),
                                child: InkWell(
                                  onTap:(){
                                  setState(() {
                                    productMachineSalesControllers.add(TextEditingController());
                                    productQuantityControllers.add(TextEditingController());
                                  });
                                },
                                  child: Center(child: Icon(Icons.add,
                                    size: size.width*0.045,
                                    color:  AppColors.contentColorCyan ,
                                    )),
                                ),
                              ),
                          ],
                        ),
                        // 
                        // container to show the added input fields
                        SizedBox(height: size.height*0.010,),
                        Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: size.width*0.01),
                            height:size.height*0.70,
                            width:size.width*0.90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColors.contentColorPurple.withOpacity(0.2)
                              )
                              // color: AppColors.contentColorPurple.withOpacity(0.3)
                            ),
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: productMachineSalesControllers.length,
                              itemBuilder: (context, index){
                                return productMachineSalesControllers.length!=0? Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(left:size.width*0.03, top: size.height*0.010),
                                            child: TextFormField(
                                              controller: productMachineSalesControllers[index],
                                              decoration: InputDecoration(
                                                labelText: 'product name',
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
                ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                child: InkWell(
                  onTap: (){
                    setState(() {
                    productMachineSalesControllers[index].clear();//first clear
                    //then dispose the controller
                    productMachineSalesControllers[index].dispose;
                    //after remove the value of the listcontroller
                    productMachineSalesControllers.removeAt(index);
      
                    //clearing the productQuantityController list
      
                    productQuantityControllers[index].clear();//first clear
                    //then dispose the controller
                    productQuantityControllers[index].dispose;
                    //after remove the value of the listcontroller
                    productQuantityControllers.removeAt(index);
                    });
                  },
                  child: index!=0?Icon(Icons.delete,
                  size: size.width*0.09,
                  ):Container(),
                ),
              ),
              ],
            ),
            //
          SizedBox(height: size.height*0.02,),
          // to capture the quantity of entered product
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
            child: TextFormField(
                  controller: productQuantityControllers[index],
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
          Divider(
            thickness: 1,
          ),
          ],
        ):Container();
      }),
      ),
      ),
      // 
      ],
          ),
          SizedBox(height: size.height*0.010,),
      ],
      ),
      ) ,
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
      ),
            SizedBox(height: size.height*0.020,),
            Center(
              child: ElevatedButton(
              onPressed: (){
                // Navigator.push(context, MaterialPageRoute(builder: (context){
                //   // return CreateVisitScreen();
                // }));
                print("==============\n");
                for(int x=0; x<productQuantityControllers.length; x=x+1){
                  
                  print(productQuantityControllers[x].text);
                  print("\n");
                }
                print("\n==============");
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width*0.26,
                  vertical: size.height*0.028,
                ),
                child: Text('submit',
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
        ),
      )
              
    );
  }
}