import 'package:valour/Utils/AppColors.dart';
import 'package:valour/Widgets/Drawer/DrawerItems.dart';
import 'package:valour/Widgets/InventoryWidgets/CoffeeProductRegistrationForm.dart';
import 'package:valour/Widgets/InventoryWidgets/MachineRegistrationForm.dart';
import 'package:valour/Widgets/SalesScreenWidgets/AvailableCoffeeProductsDisplayScreen.dart';
import 'package:valour/Widgets/SalesScreenWidgets/AvailableMachinesDisplayScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        drawer:Drawer(
        backgroundColor: AppColors.contentColorPurple,
        width: size.width*0.8,
        child: DrawerItems(),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(
        color: AppColors.contentColorPurple,
        size: size.width*0.11,
        ),  // Change the icon color here

        backgroundColor: AppColors.contentColorCyan,
 
        title: Text("Inventory",
         style: GoogleFonts.lato(
          fontSize: size.width*0.05, 
          color: AppColors.menuBackground,
          fontWeight: FontWeight.bold
        ),),
         
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height*0.014,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width*0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // container wrapping the available machine item
                    height: size.height*0.10,
                    width: size.width*0.47,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              // container wrapping the icon
                              margin: EdgeInsets.only(left: size.width*0.02, top: size.height*0.009),
                              height: size.height*0.080,
                              width: size.width*0.14,
                              decoration: BoxDecoration(
                                color: AppColors.contentColorBlue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(Icons.amp_stories_outlined,
                              size: size.width*0.08,
                              color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: size.height*0.018, right: size.width*0.02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Available machines",style: GoogleFonts.lato(
                                fontSize: size.width*0.03,
                                fontWeight:FontWeight.bold
                              ),),
                              Text("430", style:GoogleFonts.lato(
                                fontSize:size.width*0.05
                              ))
                            ],
                          ),
                        )
      
                      ],
                    ),
                   ),
                  Container(
                    height: size.height*0.10,
                    width: size.width*0.47,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: size.width*0.02, top: size.height*0.009),
                              height: size.height*0.080,
                              width: size.width*0.14,
                              decoration: BoxDecoration(
                                color: AppColors.contentColorPurple,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(Icons.sell_outlined,
                              size: size.width*0.08,
                              color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: size.height*0.018, right: size.width*0.04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Sold machines",style: GoogleFonts.lato(
                                fontSize: size.width*0.03,
                                fontWeight:FontWeight.bold
                              ),),
                              Text("340", style:GoogleFonts.lato(
                                fontSize:size.width*0.05
                              ))
                            ],
                          ),
                        )
      
                      ],
                    ),
                   ),
                   ],
              ),
            ),
            // second section of inventory menu items
            SizedBox(height: size.height*0.014,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width*0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // container wrapping the damaged machines items
                  Container(
                    height: size.height*0.10,
                    width: size.width*0.47,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            // container wrapping the icon
                            Container(
                              margin: EdgeInsets.only(left: size.width*0.02, top: size.height*0.009),
                              height: size.height*0.080,
                              width: size.width*0.14,
                              decoration: BoxDecoration(
                                color: AppColors.contentColorPink,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(Icons.home_repair_service,
                              size: size.width*0.08,
                              color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: size.height*0.018, right: size.width*0.02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Damaged machines",style: GoogleFonts.lato(
                                fontSize: size.width*0.03,
                                fontWeight:FontWeight.bold
                              ),),
                              Text("24", style:GoogleFonts.lato(
                                fontSize:size.width*0.05
                              ))
                            ],
                          ),
                        )
      
                      ],
                    ),
                   ),
                  // 
                  Container(
                    // container wraping the active machine item
                    height: size.height*0.10,
                    width: size.width*0.47,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              // container wrapping the icon
                              margin: EdgeInsets.only(left: size.width*0.02, top: size.height*0.009),
                              height: size.height*0.080,
                              width: size.width*0.14,
                              decoration: BoxDecoration(
                                color: AppColors.mainTextColor2,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(Icons.home_repair_service,
                              size: size.width*0.08,
                              color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: size.height*0.018, right: size.width*0.03),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Active machines",style: GoogleFonts.lato(
                                fontSize: size.width*0.03,
                                fontWeight:FontWeight.bold
                              ),),
                              Text("200", style:GoogleFonts.lato(
                                fontSize:size.width*0.05
                              ))
                            ],
                          ),
                        )
                      ], 
                    ),
                   ),
                   ],
              ),
            ),
            SizedBox(height: size.height*0.016,),
            // inventory report details
            Padding(
              padding: EdgeInsets.only(left: size.width*0.03),
              child: Text("Inventory report export", style: GoogleFonts.lato(
                fontSize: size.width*0.040,
                color: AppColors.contentColorBlack,
                fontWeight: FontWeight.bold
              ),),
            ),
            SizedBox(height: size.height*0.016,),
            // 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  // container print but
                  margin: EdgeInsets.only(left: size.width*0.02, top: size.height*0.009),
                  height: size.height*0.2,
                  width: size.width*0.29,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                              // container wrapping the icon
                              margin: EdgeInsets.only(left: size.width*0.02, top: size.height*0.009),
                              height: size.height*0.08,
                              width: size.width*0.14,
                              decoration: BoxDecoration(
                                color: AppColors.contentColorBlue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(Icons.print_outlined,
                              size: size.width*0.08,
                              color: Colors.white,
                              ),
                            ),
                      SizedBox(height: size.height*0.004,),
                      Text("Print", style: GoogleFonts.lato(
                        fontSize: size.width*0.045
                      ),)
                    ],
                  ),
                ),
                Container(
                  // container print but
                  margin: EdgeInsets.only(left: size.width*0.02, top: size.height*0.009),
                  height: size.height*0.2,
                  width: size.width*0.29,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                              // container wrapping the icon
                              margin: EdgeInsets.only(left: size.width*0.02, top: size.height*0.009),
                              height: size.height*0.08,
                              width: size.width*0.14,
                              decoration: BoxDecoration(
                                color: AppColors.mainTextColor2,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(Icons.explicit_outlined,
                              size: size.width*0.08,
                              color: Colors.white,
                              ),
                            ),
                      SizedBox(height: size.height*0.004,),
                      Text("Excel", style: GoogleFonts.lato(
                        fontSize: size.width*0.045
                      ),)
                    ],
                  ),
                ),
                Container(
                  // container print but
                  margin: EdgeInsets.only(left: size.width*0.02, top: size.height*0.009),
                  height: size.height*0.2,
                  width: size.width*0.29,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                              // container wrapping the icon
                              margin: EdgeInsets.only(left: size.width*0.02, top: size.height*0.009),
                              height: size.height*0.08,
                              width: size.width*0.14,
                              decoration: BoxDecoration(
                                color: AppColors.contentColorOrange,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(Icons.picture_as_pdf_sharp,
                              size: size.width*0.08,
                              color: Colors.white,
                              ),
                            ),
                      SizedBox(height: size.height*0.004,),
                      Text("Pdf", style: GoogleFonts.lato(
                        fontSize: size.width*0.045
                      ),)
                    ],
                  ),
                ),
              ],
            )
            // 
            ,SizedBox(height: size.height*0.020,),
            Padding(
              padding: EdgeInsets.only(left: size.width*0.03),
              child: Text("Registration section", style: GoogleFonts.lato(
                fontSize: size.width*0.040,
                color: AppColors.contentColorBlack,
                fontWeight: FontWeight.bold
              ),),
            ),
            SizedBox(height: size.height*0.016,),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return const MachineRegistrationScreen(machineFormMode: MachineFormMode.Add);
                }));
              },
              child: Container(
                  // container wrapping the icon
                  margin: EdgeInsets.only(left: size.width*0.02, top: size.height*0.009),
                  height: size.height*0.084,
                  width: size.width*0.95,
                  decoration: BoxDecoration(
                    color: AppColors.contentColorPurple,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text("Register a coffee machine", style: GoogleFonts.lato(
                      color: Colors.white
                    ),),
                  )
                ),
            )
            ,SizedBox(height: size.height*0.020,),
            // inventory report details
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return const CoffeeProductRegistrationFrom(formMode: FormMode.Add);
                }));
              },
              child: Container(
                  // container wrapping the icon
                  margin: EdgeInsets.only(left: size.width*0.02, top: size.height*0.009),
                  height: size.height*0.084,
                  width: size.width*0.95,
                  decoration: BoxDecoration(
                    color: AppColors.contentColorPurple,
                    borderRadius: BorderRadius.circular(10),
                  ),
                   child: Center(
                    child: Text("Register a coffee product", style: GoogleFonts.lato(
                      color: Colors.white
                    ),),
                  )
                ),
            ),
            //  
            SizedBox(height: size.height*0.020,),
            Divider(),
            Padding(
              padding: EdgeInsets.only(left: size.width*0.03),
              child: Text("View section", style: GoogleFonts.lato(
                fontSize: size.width*0.040,
                color: AppColors.contentColorBlack,
                fontWeight: FontWeight.bold
              ),),
            ),
            SizedBox(height: size.height*0.016,),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return AvailableMachineDisplayScreen(); 
                }));
              },
              child: Center(
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
                          offset: Offset(0.8, 1.0),
                          blurRadius: 4.0,
                          spreadRadius: 0.2,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                  ),
                  child:  Column(
                    children: [
                      SizedBox(height: size.height*0.04,),
                      Lottie.asset(
                    'assets/json/coffeemachine.json', // Path to your Lottie animation JSON file
                    width: size.width*0.32, // Adjust width as needed
                    height: size.height*0.14,  
                    fit: BoxFit.fill,
                      ),
                      Text("Click to view all machines", style: GoogleFonts.lato(
                        color: AppColors.contentColorPurple
                      ),)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height*0.016,),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return AvailableCoffeeProductsDisplayScreen();
                }));
              },
              child: Center(
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
                          offset: Offset(0.8, 1.0),
                          blurRadius: 4.0,
                          spreadRadius: 0.2,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                  ),
                  child:  Column(
                    children: [
                      Lottie.asset(
                    'assets/json/coffee.json', // Path to your Lottie animation JSON file
                    width: size.width*0.39, // Adjust width as needed
                    height: size.height*0.18,  
                    fit: BoxFit.fill,
                      ),
                      Text("Click to view all coffee products", style: GoogleFonts.lato(
                        color: AppColors.contentColorPurple
                      ),)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height*0.04,),
           ],
        ),
      ),
    );
  }
}