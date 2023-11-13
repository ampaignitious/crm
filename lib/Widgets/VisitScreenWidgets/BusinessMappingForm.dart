import 'package:valour/Controllers/services.dart';
import 'package:valour/Models/Product.dart';
import 'package:valour/Utils/AppColors.dart';
import 'package:valour/Utils/components/modal_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';

class BusinessMappingForm extends StatefulWidget {
  const BusinessMappingForm({super.key});
  @override
  State<BusinessMappingForm> createState() => _BusinessMappingFormState();
}

class _BusinessMappingFormState extends State<BusinessMappingForm> {
  List<Product> productList = [
    Product(
      id: 1,
      product_name: 'Product 1',
      product_price: 100,
      product_quantity: 0,
    ),
    Product(
      id: 2,
      product_name: 'Product 2',
      product_price: 200,
      product_quantity: 0,
    ),
  ];

  bool showBusinessForm = false;
  bool showContactPersonDetailForm = false;
  bool interestedColor = false;
  bool maybeColor = false;
  String? userGender;
  bool male = false;
  bool female = false;
  bool notStated = false;
  bool notinterestedColor = false;
  String? pitch_interest;

  TextEditingController businessName = TextEditingController();
  TextEditingController businessEmail = TextEditingController();
  TextEditingController businessTelNo = TextEditingController();
  TextEditingController businessPhysicalLocation = TextEditingController();
  TextEditingController personName = TextEditingController();
  TextEditingController personTelNo = TextEditingController();
  TextEditingController personEmail = TextEditingController();
  TextEditingController personGender = TextEditingController();
  TextEditingController summaryNote = TextEditingController();
  final TextEditingController _gpsLocationController = TextEditingController();
  Location location = Location();
  //get selected products
  List<Product> selectedProducts = [];

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
            '${locationData.latitude},${locationData.longitude}';
      });
    } catch (e) {
      print('Error getting GPS location: $e');
    }
  }

  //extract selected products from the list
  List<Map<String, dynamic>> getSelectedProducts() {
    List<Map<String, dynamic>> selectedProducts = [];
    for (Product product in productList) {
      if (product.product_quantity > 0) {
        //make a json object of the product
        selectedProducts.add({
          "product_id": product.id,
        });
      }
    }
    return selectedProducts;
  }

  //extract ordered products from the list
  List<Map<String, dynamic>> getOrderedProducts() {
  List<Map<String, dynamic>> orderedProducts = [];
    for (Product product in productList) {
      if (product.isOrdered == true) {
        //make a json object of the product
        orderedProducts.add({
          "product_id": product.id,
          "quantity": product.product_quantity,
      });
      }
    }
    return orderedProducts;
  }

  Future<void> submitForm() async {
    Map<String, dynamic> businessDetails = {
      "business_name": businessName.text,
      "business_telephone_contact": businessTelNo.text,
      "business_email_contact": businessEmail.text,
      "business_location": _gpsLocationController.text,
      "physical_address": businessPhysicalLocation.text,
      "contact_person_name": personName.text,
      "contact_person_telephone": personTelNo.text,
      "contact_person_email": personEmail.text,
      "contact_person_gender": userGender.toString(),
      "pitch_interest": pitch_interest.toString(),
      "notes": summaryNote.text,
      "products_of_interest": getSelectedProducts(),
      "items_of_interest": getOrderedProducts(),
    };
    AuthController authController = AuthController();

    Map<String, dynamic> response =
        await authController.addMapping(businessDetails);
    //check if response does not contain error key
    if (response.containsKey("error")) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Business registration failed"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Business registration successful"),
            backgroundColor: AppColors.contentColorYellow,
          ),
        );

        businessName.clear();
        businessEmail.clear();
        businessTelNo.clear();
        businessPhysicalLocation.clear();
        personName.clear();
        personTelNo.clear();
        personEmail.clear();
        personGender.clear();
        summaryNote.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.contentColorPurple,
          size: size.width * 0.08,
        ), // Change the icon color here
        elevation: 0.6,
        backgroundColor: AppColors.contentColorCyan,

        title: Padding(
          padding: EdgeInsets.only(left: size.width * 0.09),
          child: Text(
            "Add Business Information",
            style: GoogleFonts.lato(
                fontSize: size.width * 0.05,
                color: AppColors.menuBackground,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            margin: EdgeInsets.only(
                top: size.height * 0.02, left: size.width * 0.03),
            height: size.height * 0.85,
            width: size.width * 0.95,
            decoration: BoxDecoration(
              border: Border.all(
                  color: AppColors.contentColorPurple.withOpacity(0.2)),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
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
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: const Offset(0.8, 1.0),
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
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: size.width * 0.03),
                    child: Text(
                      "Complete the form below",
                      style: GoogleFonts.lato(
                        color: AppColors.contentColorPurple.withOpacity(0.4),
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: size.width * 0.008),
                    height: size.height * 0.08,
                    width: size.width * 0.92,
                    decoration: BoxDecoration(
                        color: AppColors.contentColorPurple,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            offset: const Offset(0.8, 1.0),
                            blurRadius: 4.0,
                            spreadRadius: 0.2,
                          ),
                        ]),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Business details",
                            style: GoogleFonts.lato(
                                color: AppColors.contentColorWhite),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                showBusinessForm = !showBusinessForm;
                              });
                            },
                            child: Icon(
                              Icons.arrow_drop_down_circle_outlined,
                              size: size.width * 0.09,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  showBusinessForm == true
                      ? Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.020,
                            ),
                            //  business name
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.03),
                              child: TextFormField(
                                controller: businessName,
                                decoration: InputDecoration(
                                  labelText: 'Enter business name',
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
                              height: size.height * 0.020,
                            ),
                            //
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.03),
                              child: TextFormField(
                                controller: businessEmail,
                                decoration: InputDecoration(
                                  labelText: 'Business email',
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
                            // business business contact
                            SizedBox(
                              height: size.height * 0.020,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.03),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: businessTelNo,
                                      decoration: InputDecoration(
                                        labelText:
                                            'Enter business telephone number',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                              color: AppColors
                                                  .contentColorPurple), // Change the border color here
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: size.width * 0.03),
                                      height: size.height * 0.08,
                                      width: size.width * 0.14,
                                      decoration: BoxDecoration(
                                          color: AppColors.contentColorCyan,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              offset: const Offset(0.8, 1.0),
                                              blurRadius: 4.0,
                                              spreadRadius: 0.2,
                                            ),
                                          ],
                                          border: Border.all(
                                              color: AppColors
                                                  .contentColorPurple
                                                  .withOpacity(0.2)),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Icon(Icons.call,
                                          color: AppColors.contentColorPurple)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.020,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.03),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      readOnly: true,
                                      controller: _gpsLocationController,
                                      decoration: InputDecoration(
                                        label: const Text("Location "),
                                        // labelText: 'Enter business GPS location',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                              color: AppColors
                                                  .contentColorPurple), // Change the border color here
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: size.width * 0.03),
                                      height: size.height * 0.08,
                                      width: size.width * 0.14,
                                      decoration: BoxDecoration(
                                          color: AppColors.contentColorCyan,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              offset: const Offset(0.8, 1.0),
                                              blurRadius: 4.0,
                                              spreadRadius: 0.2,
                                            ),
                                          ],
                                          border: Border.all(
                                              color: AppColors
                                                  .contentColorPurple
                                                  .withOpacity(0.2)),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Icon(Icons.location_on,
                                          color: AppColors.contentColorPurple)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.020,
                            ),
                            // business physical location
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.03),
                              child: TextFormField(
                                controller: businessPhysicalLocation,
                                decoration: InputDecoration(
                                  labelText: 'Enter business physical location',
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
                              height: size.height * 0.020,
                            ),
                          ],
                        )
                      : Text(""),
// end of the section to display the business details input form on dropdown allow tap

// container section that has a dropdown that shows contact person capture form on its click
                  Container(
                    margin: EdgeInsets.only(left: size.width * 0.008),
                    height: size.height * 0.08,
                    width: size.width * 0.92,
                    decoration: BoxDecoration(
                        color: AppColors.contentColorPurple,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            offset: const Offset(0.8, 1.0),
                            blurRadius: 4.0,
                            spreadRadius: 0.2,
                          ),
                        ]),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Business contact person details",
                            style: GoogleFonts.lato(
                                color: AppColors.contentColorWhite),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                showContactPersonDetailForm =
                                    !showContactPersonDetailForm;
                              });
                            },
                            child: Icon(
                              Icons.arrow_drop_down_circle_outlined,
                              size: size.width * 0.09,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
// end of the container section that has a dropdown that shows contact person capture form on its click

// section that shows the contact person capture data form on dropdowm click
                  showContactPersonDetailForm == true
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: size.height * 0.020,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.03),
                              child: TextFormField(
                                controller: personName,
                                decoration: InputDecoration(
                                  labelText: 'Contact person name',
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
                            // contact person contact
                            SizedBox(
                              height: size.height * 0.020,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.03),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: personTelNo,
                                      decoration: InputDecoration(
                                        labelText: 'Contact person Tel.No',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                              color: AppColors
                                                  .contentColorPurple), // Change the border color here
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: size.width * 0.03),
                                      height: size.height * 0.08,
                                      width: size.width * 0.14,
                                      decoration: BoxDecoration(
                                          color: AppColors.contentColorCyan,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              offset: const Offset(0.8, 1.0),
                                              blurRadius: 4.0,
                                              spreadRadius: 0.2,
                                            ),
                                          ],
                                          border: Border.all(
                                              color: AppColors
                                                  .contentColorPurple
                                                  .withOpacity(0.2)),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Icon(Icons.call,
                                          color: AppColors.contentColorPurple)),
                                ],
                              ),
                            ),
                            // contact person email
                            SizedBox(
                              height: size.height * 0.020,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.03),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: personEmail,
                                      decoration: InputDecoration(
                                        labelText: 'Contact person email',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: const BorderSide(
                                              color: AppColors
                                                  .contentColorPurple), // Change the border color here
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: size.width * 0.03),
                                      height: size.height * 0.08,
                                      width: size.width * 0.14,
                                      decoration: BoxDecoration(
                                          color: AppColors.contentColorCyan,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              offset: const Offset(0.8, 1.0),
                                              blurRadius: 4.0,
                                              spreadRadius: 0.2,
                                            ),
                                          ],
                                          border: Border.all(
                                              color: AppColors
                                                  .contentColorPurple
                                                  .withOpacity(0.2)),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Icon(Icons.email_outlined,
                                          color: AppColors.contentColorPurple)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.015,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: size.width * 0.06,
                              ),
                              child: Text(
                                "Select gender",
                                style: GoogleFonts.lato(
                                  fontSize: size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.contentColorPurple,
                                ),
                              ),
                            ),
                            // showing interest status
                            SizedBox(
                              height: size.height * 0.015,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          userGender = "male";
                                          male = !male;
                                          female = false;
                                          notStated = false;
                                        });
                                      },
                                      child: Container(
                                        height: size.height * 0.03,
                                        width: size.width * 0.06,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: AppColors
                                                    .contentColorPurple)),
                                        child: Center(
                                            child: Icon(
                                          Icons.task_alt_rounded,
                                          size: size.width * 0.045,
                                          color: male == true
                                              ? AppColors.contentColorPurple
                                              : Colors.white.withOpacity(0.1),
                                        )),
                                      ),
                                    ),
                                    Text(
                                      "Male",
                                      style: GoogleFonts.lato(
                                          fontSize: size.width * 0.03),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          userGender = "female";
                                          male = false;
                                          female = !female;
                                          notStated = false;
                                        });
                                      },
                                      child: Container(
                                          height: size.height * 0.03,
                                          width: size.width * 0.06,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: AppColors
                                                    .contentColorPurple,
                                              )),
                                          child: Center(
                                              child: Icon(
                                            Icons.task_alt_rounded,
                                            size: size.width * 0.045,
                                            color: female == true
                                                ? AppColors.contentColorPurple
                                                : Colors.white.withOpacity(0.1),
                                          ))),
                                    ),
                                    Text(
                                      "Female",
                                      style: GoogleFonts.lato(
                                          fontSize: size.width * 0.03),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      height: size.height * 0.03,
                                      width: size.width * 0.06,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: AppColors
                                                  .contentColorPurple)),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            userGender = "not stated";
                                            male = false;
                                            female = false;
                                            notStated = !notStated;
                                          });
                                        },
                                        child: Center(
                                            child: Icon(
                                          Icons.task_alt_rounded,
                                          size: size.width * 0.045,
                                          color: notStated == true
                                              ? AppColors.contentColorPurple
                                              : Colors.white.withOpacity(0.1),
                                        )),
                                      ),
                                    ),
                                    Text(
                                      "Rather not to say",
                                      style: GoogleFonts.lato(
                                          fontSize: size.width * 0.03),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            //
                            SizedBox(
                              height: size.height * 0.020,
                            ),
                          ],
                        )
                      : const Text(""),
// end of the section that shows the contact person capture data form on dropdowm click

//  container displaying Product of interests title
                  Container(
                    margin: EdgeInsets.only(left: size.width * 0.008),
                    height: size.height * 0.08,
                    width: size.width * 0.92,
                    decoration: BoxDecoration(
                        color: AppColors.contentColorPurple,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            offset: Offset(0.8, 1.0),
                            blurRadius: 4.0,
                            spreadRadius: 0.2,
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Products of interest",
                                style: GoogleFonts.lato(
                                    color: AppColors.contentColorWhite)),
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            IconButton(
                              //add a plus icon
                              icon: Icon(
                                Icons.add,
                                color: AppColors.contentColorCyan,
                                size: size.width * 0.05,
                              ),
                              onPressed: () {
                                ModalUtils.showSimpleModalDialog(
                                    context, productList,
                                    isOrder: false);
                              },
                            ),
                          ]),
                    ),
                  ),
// end of the container displaying Product of interests title
                  SizedBox(
                    height: size.height * 0.020,
                  ),

                  SizedBox(
                    height: size.height * 0.020,
                  ),

//  container displaying the product of interest title
                  Container(
                    margin: EdgeInsets.only(left: size.width * 0.008),
                    height: size.height * 0.08,
                    width: size.width * 0.92,
                    decoration: BoxDecoration(
                        color: AppColors.contentColorPurple,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            offset: Offset(0.8, 1.0),
                            blurRadius: 4.0,
                            spreadRadius: 0.2,
                          ),
                        ]),
                    child: Center(
                      child: Text(
                        "Business Intereseted?",
                        style: GoogleFonts.lato(
                            color: AppColors.contentColorWhite),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.012,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                interestedColor = !interestedColor;
                                notinterestedColor = false;
                                maybeColor = false;
                                pitch_interest = "Interested";
                              });
                            },
                            child: Container(
                              height: size.height * 0.03,
                              width: size.width * 0.06,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: AppColors.contentColorPurple)),
                              child: Center(
                                  child: Icon(
                                Icons.task_alt_rounded,
                                size: size.width * 0.045,
                                color: interestedColor == true
                                    ? AppColors.contentColorPurple
                                    : Colors.white.withOpacity(0.1),
                              )),
                            ),
                          ),
                          Text(
                            "Interested",
                            style:
                                GoogleFonts.lato(fontSize: size.width * 0.03),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                interestedColor = false;
                                notinterestedColor = false;
                                maybeColor = !maybeColor;
                                pitch_interest = "May be";
                              });
                            },
                            child: Container(
                                height: size.height * 0.03,
                                width: size.width * 0.06,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.contentColorPurple,
                                    )),
                                child: Center(
                                    child: Icon(
                                  Icons.task_alt_rounded,
                                  size: size.width * 0.045,
                                  color: maybeColor == true
                                      ? AppColors.contentColorPurple
                                      : Colors.white.withOpacity(0.1),
                                ))),
                          ),
                          Text(
                            "Maybe",
                            style:
                                GoogleFonts.lato(fontSize: size.width * 0.03),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: size.height * 0.03,
                            width: size.width * 0.06,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppColors.contentColorPurple)),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  interestedColor = false;
                                  notinterestedColor = !notinterestedColor;
                                  maybeColor = false;
                                  pitch_interest = "Not interested";
                                });
                              },
                              child: Center(
                                  child: Icon(
                                Icons.task_alt_rounded,
                                size: size.width * 0.045,
                                color: notinterestedColor == true
                                    ? AppColors.contentColorPurple
                                    : Colors.white.withOpacity(0.1),
                              )),
                            ),
                          ),
                          Text(
                            "Not interested",
                            style:
                                GoogleFonts.lato(fontSize: size.width * 0.03),
                          )
                        ],
                      ),
                    ],
                  ),
                  interestedColor == true
                      ? Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Select the products to order:",
                                    style: GoogleFonts.lato(
                                        color: AppColors.contentColorPurple)),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                IconButton(
                                  //add a plus icon
                                  icon: Icon(
                                    Icons.add,
                                    color: AppColors.contentColorPurple,
                                    size: size.width * 0.05,
                                  ),
                                  onPressed: () {
                                    ModalUtils.showSimpleModalDialog(
                                        context, productList);
                                  },
                                ),
                              ]),
                        )
                      : const Text(""),
// end of the section on clicking the interested option, this section shows the input forms with product name abd quantity to allow a user
// add product of interest.

// summary notes
                  Divider(),
                  SizedBox(
                    height: size.height * 0.010,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.03),
                    child: TextFormField(
                      controller: summaryNote,
                      maxLines: 7, // Set the maximum number of lines
                      minLines: 5,
                      decoration: InputDecoration(
                        labelText: 'Record summary notes',
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

// end of the section for capturing the record summary notes input field

                  SizedBox(
                    height: size.height * 0.020,
                  ),

// The button display section
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
                          'Add Business',
                          style: GoogleFonts.lato(
                            fontSize: size.width * 0.035,
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
            ),
          )
        ]),
      ),
    );
  }
}
