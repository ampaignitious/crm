import 'package:crm/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
class BusinessMappingForm extends StatefulWidget {
  const BusinessMappingForm({super.key});

  @override
  State<BusinessMappingForm> createState() => _BusinessMappingFormState();
}

class _BusinessMappingFormState extends State<BusinessMappingForm> {
  @override
// 
TextEditingController _gpsLocationController = TextEditingController();
  Location location = Location();

  @override
  void initState() {
    super.initState();
    _captureGPSLocation();
  }

  Future<void> _captureGPSLocation() async {
    try {
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return;
        }
      }

      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      LocationData locationData = await location.getLocation();
      setState(() {
        _gpsLocationController.text =
            'Latitude: ${locationData.latitude}, Longitude: ${locationData.longitude}';
      });
    } catch (e) {
      print('Error getting GPS location: $e');
    }
  }
// 
  // 
    final List<VisitData> visitDataList = [
    VisitData("1", "Mohit", "working for the best"),
    VisitData("2", "Ankit", "working for the best"),
    VisitData("3", "Rakhi", "working for the best"),
    VisitData("4", "Yash", "working for the best"),
    VisitData("300", "Pragati", "working for the best"),
    VisitData("300", "Pragati", "working for the best"),
    VisitData("300", "Pragati", "working for the best"),
    VisitData("300", "Pragati", "working for the best"),
    VisitData("300", "Pragati", "working for the best"),
  ];

    List<VisitData> filteredProducts = [];

  List<VisitData> productsOfInterest = [];

// 
 void _filterProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredProducts.clear();
        return;
      }

      filteredProducts = visitDataList
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
  bool productOfInterestClicked=false;
    bool showSelectedProductsOfInterest = false;
  void _showProducts() {
    setState(() {
      productOfInterestClicked=!productOfInterestClicked;
      filteredProducts = visitDataList;
      showSelectedProductsOfInterest = false;
    });
  } 
// 
void _removeFromProductsOfInterest(VisitData product) {
    setState(() {
      productsOfInterest.remove(product);
    });
  }
  // 
  bool showBusinessForm = false;
  bool showContactPersonDetailForm = false;
  bool interestedColor = false;
  bool maybeColor =false;
  bool notinterestedColor =false;
  List<TextEditingController> productListControllers = [TextEditingController()];
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
          child: Text("Business mapping form",
           style: GoogleFonts.lato(
            fontSize: size.width*0.05, 
            color: AppColors.menuBackground,
            fontWeight: FontWeight.bold
          ),),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height*0.015,),
                      Padding(
                        padding:EdgeInsets.only(left:size.width*0.03),
                        child: Text("Complete the form below", style: GoogleFonts.lato(
                        color: AppColors.contentColorPurple.withOpacity(0.4),
                        ),),
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      // section for capturing business details
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
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Business details",style: GoogleFonts.lato(
                          color: AppColors.contentColorWhite
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          setState(() {
                            showBusinessForm = !showBusinessForm;
                          });
                        },
                        child: Icon(
                          Icons.arrow_drop_down_circle_outlined,
                          size: size.width*0.09,
                          color: Colors.white,
                          ),
                      )
                    ],
                  ),
                ),
              ),     
              //
              showBusinessForm==true?Column(
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
                   
                  // business business contact
                  SizedBox(height: size.height*0.020,),
                           Padding(
                             padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                             child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Enter business contact',
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
                                  child: Icon(Icons.call, color: AppColors.contentColorPurple)),
                              ],
                              ),
                           ),
                          
                  // 
                  // business location gps
                  SizedBox(height: size.height*0.020,),
                           Padding(
                             padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                             child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _gpsLocationController,
                                    decoration: InputDecoration(
                                      label: Text("Capture GPS location "),
                                      // labelText: 'Enter business GPS location',
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
                           ),
                     SizedBox(height: size.height*0.020,),
                     // business physical location
                     Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                    child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Enter business physical location',
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
              ],):Text(""),
              // business contact person name
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
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Business contact person details",style: GoogleFonts.lato(
                          color: AppColors.contentColorWhite
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          setState(() {
                            showContactPersonDetailForm = !showContactPersonDetailForm;
                          });
                        },
                        child: Icon(
                          Icons.arrow_drop_down_circle_outlined,
                          size: size.width*0.09,
                          color: Colors.white,
                          ),
                      )
                    ],
                  ),
                ),
              ),     
              //
              showContactPersonDetailForm==true?Column(
                children: [
                  SizedBox(height: size.height*0.020,),
                   Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                    child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Contact person name',
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
                  // contact person contact
                SizedBox(height: size.height*0.020,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                  child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Contact person Tel.No',
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
                      child: Icon(Icons.call, color: AppColors.contentColorPurple)),
                  ],
                                    ),
                ),
              
                // 
                  // contact person email
                  SizedBox(height: size.height*0.020,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                    child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Contact person email',
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
                        child: Icon(Icons.email_outlined, color: AppColors.contentColorPurple)),
                    ],
                                      ),
                  ),
                SizedBox(height: size.height*0.020,),
                ],
              ):Text(""),
              //  Product of interests
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
                    "Products of interest",style: GoogleFonts.lato(
                      color: AppColors.contentColorWhite
                    ),
                  ),
                ),
              ),     
              //
              SizedBox(height: size.height*0.020,),
                  // business contact person name
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                        child: TextFormField(
                          onTap: _showProducts, // Display products when tapping the text field
                          onChanged: _filterProducts,
                          decoration: InputDecoration(
                            labelText: 'Select products of interest',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.blue), // Change the border color here
                            ),
                          ),
                        ),
                        ),
                      ),
                      // to track the section completion
                      InkWell(
                        onTap:(){
                          setState(() {
                            productOfInterestClicked =false;
                            showSelectedProductsOfInterest!=showSelectedProductsOfInterest;
                          });
                          
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: size.width*0.04),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height:size.height*0.008),
                              Icon(Icons.done,
                              size: size.width*0.05,
                              ),
                              Text("Done", style: GoogleFonts.lato(
                                fontSize:size.width*0.03
                              ),)
                            ],
                          ),
                        ),
                      )
                    ],
                    // 
                  ),
                // section to display the filter list of products from the database
                productOfInterestClicked==true?Container(
                  height: size.height*0.35,
                  width:double.maxFinite,
                  child: ListView.builder(
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      VisitData product = filteredProducts[index];
                      return ListTile(
                        title: Text(product.name),
                        subtitle: Text(product.description),
                        trailing: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              productsOfInterest.add(product);
                            });
                            print(productsOfInterest.length);
                          },
                        ),
                      );
                    },
                  ),
                ):Container() ,
                // 
                //section to show selected products from inventory with a cancel button 
               showSelectedProductsOfInterest==true? Column(
                  children: [
                    Text("Selected products"),
                    Container(
                      height: size.height*0.35,
                      width:double.maxFinite,
                       child: ListView.builder(
                        itemCount: productsOfInterest.length,
                        itemBuilder: (context, index) {
                          VisitData product = productsOfInterest[index];
                          return ListTile(
                            title: Text(product.name),
                            subtitle: Text(product.description),
                            trailing: IconButton(
                              icon: Icon(Icons.cancel),
                              onPressed: () {
                                _removeFromProductsOfInterest(product);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ):Container(),
                //end of section to show selected products form inventory with a cancel button
                SizedBox(height: size.height*0.020,),
                 
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
                    "Pitch interest",style: GoogleFonts.lato(
                      color: AppColors.contentColorWhite
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height*0.012,) ,
              // showing interest status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: (){
                          setState(() {
                            interestedColor =!interestedColor;
                            notinterestedColor = false;
                            maybeColor =false;
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
                          color: interestedColor==true?AppColors.contentColorPurple:Colors.white,
                          )),
                        ),
                      ),
                      Text("Interested", style: GoogleFonts.lato(
                        fontSize:size.width*0.03
                      ),)
                    ],
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap:(){
                          setState(() {
                            interestedColor =false;
                            notinterestedColor = false;
                            maybeColor =!maybeColor;
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
                          color: maybeColor==true?AppColors.contentColorPurple:Colors.white,
                          ))
                        ),
                      ),
                      Text("Maybe", style: GoogleFonts.lato(
                        fontSize:size.width*0.03
                      ),)
                    ],
                  ),
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
                            interestedColor =false;
                            notinterestedColor = !notinterestedColor;
                            maybeColor =false;
                          });
                        },
                          child: Center(child: Icon(Icons.task_alt_rounded,
                            size: size.width*0.045,
                            color: notinterestedColor==true?AppColors.contentColorPurple:Colors.white,
                            )),
                        ),
                      ),
                      Text("Not interested", style: GoogleFonts.lato(
                        fontSize:size.width*0.03
                      ),)
                    ],
                  ),
      
                ],
              ),
              // 
              //end of the pitch interest container section
              interestedColor ==true?  
                //  provision for adding items required
              Column(
                children: [
                  SizedBox(height: size.height*0.020,),
                  Container(
                      margin: EdgeInsets.only(left: size.width*0.008),
                      height: size.height*0.08,
                      width: size.width*0.92,
                      decoration: BoxDecoration(
                        color:AppColors.contentColorPurple.withOpacity(0.5),
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
                        "Add products required",style: GoogleFonts.lato(
                          color: AppColors.contentColorWhite
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: size.height*0.020,),
                Column(
                  children: [
                    // row showing click to add input and the add button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left:size.width*0.09),
                          child: Text("Click to add more input field", style: GoogleFonts.lato(
                            fontSize: size.width*0.04
                          ),),
                        ),
                         Container(
                          margin: EdgeInsets.only(right:size.width*0.04),
                            height: size.height*0.05,
                            width: size.width*0.09,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                               border: Border.all(
                                color: AppColors.contentColorPurple
                               )
                            ),
                            child: InkWell(
                              onTap:(){
                              setState(() {
                                productListControllers.add(TextEditingController());
                              });
                            },
                              child: Center(child: Icon(Icons.add,
                                size: size.width*0.045,
                                color:  AppColors.contentColorPurple ,
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
                        height:size.height*0.34,
                        width:size.width*0.90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.contentColorPurple
                          )
                          // color: AppColors.contentColorPurple.withOpacity(0.3)
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: productListControllers.length,
                          itemBuilder: (context, index){
                            return productListControllers.length!=0? Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(left:size.width*0.03, top: size.height*0.018),
                                        child: TextFormField(
                                          controller: productListControllers[index],
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
                                        productListControllers[index].clear();//first clear
                                        //then dispose the controller
                                        productListControllers[index].dispose;
                                        //after remove the value of the listcontroller
                                        productListControllers.removeAt(index);
                                        });
                                      },
                                      child: index!=0?Icon(Icons.delete,
                                      size: size.width*0.09,
                                      ):Container(),
                                    ),
                                  ),
                                  ],
                                ),
                                SizedBox(height: size.height*0.012,),
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
              ):Text(''),
              // summary notes
              Divider(),
              SizedBox(height: size.height*0.010,),
              Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                    child: TextFormField(
                        maxLines: 7,  // Set the maximum number of lines
                        minLines: 5,
                            decoration: InputDecoration(
                              labelText: 'Record summary notes',
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
                      child: Text('Record the mapping',
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
                ],
              ),
            ),
            )
          ]),
      ),
    );
  }
}

class VisitData {
  final String id;
  final String name;
  final String description;

  VisitData(this.id, this.name, this.description);
} 