import 'package:crm/Models/VisitData.dart';
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
  //  list to capture products and quantity
    //texteditingcollectingcontroller for sales data
  List<TextEditingController> productListControllers = [TextEditingController()];
  List<TextEditingController> productQuantityControllers = [TextEditingController()];


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
    List quantity =[];
    TextEditingController quantityEntered = TextEditingController();
    List products =[];

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
      // showSelectedProductsOfInterest = false;
    });
  } 
// 
void _removeFromProductsOfInterest(VisitData product) {
    setState(() {
      productsOfInterest.remove(product);
    });
  }
void _removeFromProducts(int? index) {
  print(index);
  setState(() {
      products.removeAt(index!);
      quantity.removeAt(index!);
  });
  }
  // 
  bool showBusinessForm = false;
  bool showContactPersonDetailForm = false;
  bool interestedColor = false;
  bool maybeColor =false;
  String? userGender ;
  bool male = false;
  bool female = false;
  bool notStated= false;
  bool notinterestedColor =false;
  bool addedIsClicked = false;
  // List<TextEditingController> productListControllers = [TextEditingController()];
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

              // showing the business details input form on dropdown allow tap
              showBusinessForm==true?Column(
                children: [
                 SizedBox(height: size.height*0.020,),
                //  business name
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
                // 
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                    child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Business email',
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
                            labelText: 'Enter business telephone number',
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
                      readOnly: true,
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
              // end of the section to display the business details input form on dropdown allow tap



              // container section that has a dropdown that shows contact person capture form on its click
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
              // end of the container section that has a dropdown that shows contact person capture form on its click
              

              // section that shows the contact person capture data form on dropdowm click
              showContactPersonDetailForm==true?Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
              SizedBox(height: size.height*0.015,) ,
                Padding(
                  padding: EdgeInsets.only(left:size.width*0.06 ,),
                  child: Text("Select gender", style: GoogleFonts.lato(
                    fontSize:size.width*0.05,
                    fontWeight:FontWeight.bold,
                    color:AppColors.contentColorPurple,
                  ),),
                ),
              // showing interest status
              SizedBox(height: size.height*0.015,) ,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: (){
                          setState(() {
                            userGender ="male";
                            male = !male;
                            female = false;
                            notStated = false;
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
                          color: male==true?AppColors.contentColorPurple:Colors.white.withOpacity(0.1),
                          )),
                        ),
                      ),
                      Text("Male", style: GoogleFonts.lato(
                        fontSize:size.width*0.03
                      ),)
                    ],
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap:(){
                          setState(() {
                            userGender="female";
                            male = false;
                            female = !female;
                            notStated = false;
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
                          color: female==true?AppColors.contentColorPurple:Colors.white.withOpacity(0.1),
                          ))
                        ),
                      ),
                      Text("Female", style: GoogleFonts.lato(
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
                            userGender="not stated";
                            male = false;
                            female = false;
                            notStated = !notStated;
                          });
                        },
                          child: Center(child: Icon(Icons.task_alt_rounded,
                            size: size.width*0.045,
                            color: notStated==true?AppColors.contentColorPurple:Colors.white.withOpacity(0.1),
                            )),
                        ),
                      ),
                      Text("Rather not to say", style: GoogleFonts.lato(
                        fontSize:size.width*0.03
                      ),)
                    ],
                  ),
      
                ],
              ),
              //
                SizedBox(height: size.height*0.020,),
                ],
              ):Text(""),
               // end of the section that shows the contact person capture data form on dropdowm click
              
              
              //  container displaying Product of interests title
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
              // end of the container displaying Product of interests title
              SizedBox(height: size.height*0.020,),
              
              //  section showing input section for select products of interest , with a done buttone
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                      child: TextFormField(
                        // readOnly: true,
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
                          showSelectedProductsOfInterest=!showSelectedProductsOfInterest;
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
              //  end of the section showing input section for select products of interest , with a done buttone
              
              
              // section to display the list of products from the database on tapping the select product of interest input field
                productOfInterestClicked==true?Container(
                  height: size.height*0.35,
                  width:double.maxFinite,
                  child: ListView.builder(
                    itemCount: visitDataList.length,
                    itemBuilder: (context, index) {
                      VisitData productData = filteredProducts[index];
                      return GestureDetector(
                        onTap: (){
                            String? productName = productData.name;
                             int? productindex = index;
                             dynamic headersize = size.width*0.04; 
                             dynamic productnameSize = size.width*0.038;
                             dynamic boxSize = size.width*0.02;
                            showDialog(
                            context: context,
                            builder: (context) {
                            return productQuantityCard("$productName",productindex,headersize,productnameSize,boxSize); // Show the EditProfileDialog
                            },
                          );
                          },
                        child: Card(
                          color: AppColors.contentColorCyan,
                          child: ListTile(
                            title: Text(productData.name),
                            subtitle: Text(productData.description),
                            trailing: Icon(Icons.add,),
                          ),
                        ),
                      );
                    },
                  ),
                ):Container() ,
              // end of the section to display the list of products from the database on tapping the select product of interest input field
              
              
              //section to show selected products from inventory on tapping the done button, the products are displayed with a cancle button,
              // to allow you remove a product incase your not interested in it
               showSelectedProductsOfInterest==true? Column(
                  children: [
                    SizedBox(height:size.height*0.004),
                    Text("Selected products"),
                    Container(
                      height: size.height*0.35,
                      width:double.maxFinite,
                       child: ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          // VisitData product = productsOfInterest[index];
                          return ListTile(
                            title: Text("${products[index]}"),
                            subtitle: Text("Quantity: ${quantity[index]}"),
                            trailing: IconButton(
                              icon: Icon(Icons.cancel),
                              onPressed: () {
                                   _removeFromProducts(index);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ):Container(),
              //end of the section that shows selected products from inventory on tapping the done button, the products are displayed with a cancle button,
              // to allow you remove a product incase your not interested in it.

              SizedBox(height: size.height*0.020,),
                 
              //  container displaying the product of interest title
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
                    "Product of interest",style: GoogleFonts.lato(
                      color: AppColors.contentColorWhite
                    ),
                  ),
                ),
              ),
              //  end of the container displaying the product of interest title
                SizedBox(height: size.height*0.012,) ,

              // The section that shows the selection option under product of interest container
              // the select options include interested, maybe , not intereseted
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
                          color: interestedColor==true?AppColors.contentColorPurple:Colors.white.withOpacity(0.1),
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
                          color: maybeColor==true?AppColors.contentColorPurple:Colors.white.withOpacity(0.1),
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
                            color: notinterestedColor==true?AppColors.contentColorPurple:Colors.white.withOpacity(0.1),
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
              // rnd of the  section that shows the selection option under product of interest container
              // the select options include interested, maybe , not intereseted


              // on clicking the interested option, this section shows the input forms with product name abd quantity to allow a user
              // add product of interest.
              interestedColor ==true?  
                //  provision for adding items required
               Container(
                margin: EdgeInsets.only(left: size.width*0.03, right: size.width*0.03,top: size.height*0.008),
                height: size.height*0.39,
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
                              productListControllers.add(TextEditingController());
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
                      height:size.height*0.32,
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
                        itemCount: productListControllers.length,
                        itemBuilder: (context, index){
                          return productListControllers.length!=0? Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(left:size.width*0.03, top: size.height*0.010),
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
              ):Container(),
              // end of the section on clicking the interested option, this section shows the input forms with product name abd quantity to allow a user
              // add product of interest.
              
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

              // end of the section for capturing the record summary notes input field

              SizedBox(height: size.height*0.020,),

              // The button display section
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


  // widget dispklaying alert box to capture product and quantity, when you tap on pitch interest
 Widget productQuantityCard(String? productName, int? productindex, dynamic headersize, dynamic productnameSize, dynamic boxSize){
  return AlertDialog(
      title: Center(
        child: Text("Add product quuantity", style: GoogleFonts.lato(
          color: AppColors.contentColorPurple,
          fontWeight: FontWeight.bold,
          fontSize: headersize,
        )),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(thickness: 1,),
        Text("Product name", style: GoogleFonts.lato(
          fontWeight:FontWeight.bold,
          fontSize: productnameSize
        ),),
        Text("${productName}", style: GoogleFonts.lato(
          color:AppColors.contentColorPurple,
          fontWeight:FontWeight.bold
        ),),
        SizedBox(height: boxSize),
        TextFormField(
          controller: quantityEntered,
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
        SizedBox(height: boxSize),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(onPressed: (){
              setState(() {
                products.add(productName);
            quantity.add(quantityEntered.text);
              });
              // SnackBar(content: content),
              Navigator.pop(context);
            }, 
            style: ElevatedButton.styleFrom(
              primary: AppColors.contentColorPurple,  // Set button color to purple
            ),
            child: Text("Add")),
            //
            ElevatedButton(onPressed: (){
            Navigator.pop(context);
            }, 
            style: ElevatedButton.styleFrom(
              primary: AppColors.contentColorYellow,  // Set button color to purple
            ),
            child: Text("Cancel")),
          ],
        )
      ],
    ));
  
 }
  // 
}

