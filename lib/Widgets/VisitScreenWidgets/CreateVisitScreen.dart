import 'package:valour/Controllers/services.dart';
import 'package:valour/Models/Product.dart';
import 'package:valour/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:valour/Utils/components/modal_util.dart';

class CreateVisitScreen extends StatefulWidget {
  final int businessId;
  const CreateVisitScreen({super.key, required this.businessId});

  @override
  State<CreateVisitScreen> createState() => _CreateVisitScreenState();
}

class _CreateVisitScreenState extends State<CreateVisitScreen> {
  List<Product> productList = [];

  bool maintenance = true;
  bool demo = false;
  bool delivery = false;
  bool appointment = false;
  bool sales = false;

  //maintenance
  TextEditingController maintenanceDate = TextEditingController();
  TextEditingController maintenanceComment = TextEditingController();

  //demo
  TextEditingController demoDate = TextEditingController();
  TextEditingController demoNotes = TextEditingController();

  //Appointment
  TextEditingController appointmentDate = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController appointmentNotes = TextEditingController();

  //common visit notes controller
  TextEditingController visitNotesController = TextEditingController();

    @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    List<Product> products = await ModalUtils.getProducts();
    setState(() {
      productList = products;
    });
  }

  //extract ordered products from the list
  List<Map<String, dynamic>> getOrderedProducts() {
    List<Map<String, dynamic>> orderedProducts = [];
    for (Product product in productList) {
      if (product.isSelected == true) {
        //make a json object of the product
        orderedProducts.add({
          "product_id": product.id,
          "quantity": product.product_quantity,
        });
      }
    }
    return orderedProducts;
  }

    List<Map<String, dynamic>> getSelectedProducts() {
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

  //submit the visit form
  Future<void> submitForm() async {
    Map<String, dynamic> body = {};
    if (maintenance) {
      body = {
        "business_id": widget.businessId,
        "visit_notes": visitNotesController.text,
        "visit_purpose": "Maintenance",
        "date_of_maintenance": maintenanceDate.text,
        "comment": maintenanceComment.text,
        "maintenance_products": getSelectedProducts()
      };
    }

    if (demo) {
      body = {
        "business_id": widget.businessId,
        "visit_notes": visitNotesController.text,
        "visit_purpose": "Demo",
        "demo_date": demoDate.text,
        "demo_notes": demoNotes.text
      };
    }

    if (delivery) {
      body = {
        "business_id": widget.businessId,
        "visit_notes": visitNotesController.text,
        "visit_purpose": "Delivery",
        "delivery_products": getOrderedProducts()
      };
    }

    if (appointment) {
      body = {
        "business_id": widget.businessId,
        "visit_notes": visitNotesController.text,
        "visit_purpose": "Appointment",
        "meeting_date": appointmentDate.text,
        "meeting_start_time": startTimeController.text,
        "meeting_end_time": endTimeController.text,
        "meeting_notes": appointmentNotes.text
      };
    }

    if (sales) {
      body = {
        "business_id": widget.businessId,
        "visit_notes": visitNotesController.text,
        "visit_purpose": "Sale",
        "sale_products": getOrderedProducts()
      };
    }

          print("ordered products $body");
    print("selected products $body");
    AuthController authController = AuthController();

    final response = await authController.addVisit(body);

    if (response.containsKey('message')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            response['message'],
            style: GoogleFonts.lato(
              color: AppColors.contentColorPurple,
            ),
          ),
          backgroundColor: AppColors.contentColorYellow,
        ),
      );

      clearControllers();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            response['error'],
            style: GoogleFonts.lato(
              color: AppColors.contentColorPurple,
            ),
          ),
          backgroundColor: Colors.purple,
        ),
      );
    }
  }

  void clearControllers() {
    maintenanceDate.clear();
    maintenanceComment.clear();
    demoDate.clear();
    demoNotes.clear();
    appointmentDate.clear();
    startTimeController.clear();
    endTimeController.clear();
    appointmentNotes.clear();
    visitNotesController.clear();
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
            "Add a visit",
            style: GoogleFonts.lato(
                fontSize: size.width * 0.058,
                color: AppColors.contentColorPurple,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
              height: size.height * 0.29,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
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
              )),
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
              child: Center(
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      Center(
                        child: Text(
                          "complete the form below",
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
                      Form(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //
                          //  pitch interest container
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
                            child: Center(
                              child: Text(
                                "Visit purpose",
                                style: GoogleFonts.lato(
                                    color: AppColors.contentColorWhite),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.008,
                          ),
                          // showing interest status
                          Padding(
                            padding: EdgeInsets.only(left: size.width * 0.03),
                            child: Text(
                              "Select one visit purpose to capture its additional details",
                              style: GoogleFonts.lato(
                                fontSize: size.width * 0.028,
                                color: AppColors.contentColorPurple
                                    .withOpacity(0.4),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.015,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // maintenance
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        demo = false;
                                        maintenance = !maintenance;
                                        delivery = false;
                                        appointment = false;
                                        sales = false;
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
                                        color: maintenance == true
                                            ? AppColors.contentColorPurple
                                            : Colors.white.withOpacity(0.1),
                                      )),
                                    ),
                                  ),
                                  Text(
                                    "Maintenance",
                                    style: GoogleFonts.lato(
                                        fontSize: size.width * 0.03),
                                  )
                                ],
                              ),
                              //
                              // Demo
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        demo = !demo;
                                        maintenance = false;
                                        delivery = false;
                                        appointment = false;
                                        sales = false;
                                      });
                                    },
                                    child: Container(
                                        height: size.height * 0.03,
                                        width: size.width * 0.06,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color:
                                                  AppColors.contentColorPurple,
                                            )),
                                        child: Center(
                                            child: Icon(
                                          Icons.task_alt_rounded,
                                          size: size.width * 0.045,
                                          color: demo == true
                                              ? AppColors.contentColorPurple
                                              : Colors.white.withOpacity(0.1),
                                        ))),
                                  ),
                                  Text(
                                    "Demo",
                                    style: GoogleFonts.lato(
                                        fontSize: size.width * 0.03),
                                  )
                                ],
                              ),
                              //
                              // Delivery
                              Column(
                                children: [
                                  Container(
                                    height: size.height * 0.03,
                                    width: size.width * 0.06,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color:
                                                AppColors.contentColorPurple)),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          demo = false;
                                          maintenance = false;
                                          appointment = false;
                                          sales = false;
                                          delivery = !delivery;
                                        });
                                      },
                                      child: Center(
                                          child: Icon(
                                        Icons.task_alt_rounded,
                                        size: size.width * 0.045,
                                        color: delivery == true
                                            ? AppColors.contentColorPurple
                                            : Colors.white.withOpacity(0.1),
                                      )),
                                    ),
                                  ),
                                  Text(
                                    "Delivery",
                                    style: GoogleFonts.lato(
                                        fontSize: size.width * 0.03),
                                  )
                                ],
                              ),
                              //
                              // Appointment
                              Column(
                                children: [
                                  Container(
                                    height: size.height * 0.03,
                                    width: size.width * 0.06,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color:
                                                AppColors.contentColorPurple)),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          demo = false;
                                          maintenance = false;
                                          delivery = false;
                                          appointment = !appointment;
                                          sales = false;
                                        });
                                      },
                                      child: Center(
                                          child: Icon(
                                        Icons.task_alt_rounded,
                                        size: size.width * 0.045,
                                        color: appointment == true
                                            ? AppColors.contentColorPurple
                                            : Colors.white.withOpacity(0.1),
                                      )),
                                    ),
                                  ),
                                  Text(
                                    "Appointment",
                                    style: GoogleFonts.lato(
                                        fontSize: size.width * 0.03),
                                  )
                                ],
                              ),
                              //
                              // sales
                              Column(
                                children: [
                                  Container(
                                    height: size.height * 0.03,
                                    width: size.width * 0.06,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color:
                                                AppColors.contentColorPurple)),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          demo = false;
                                          maintenance = false;
                                          delivery = false;
                                          appointment = false;
                                          sales = !sales;
                                        });
                                      },
                                      child: Center(
                                          child: Icon(
                                        Icons.task_alt_rounded,
                                        size: size.width * 0.045,
                                        color: sales == true
                                            ? AppColors.contentColorPurple
                                            : Colors.white.withOpacity(0.1),
                                      )),
                                    ),
                                  ),
                                  Text(
                                    "Sales",
                                    style: GoogleFonts.lato(
                                        fontSize: size.width * 0.03),
                                  )
                                ],
                              ),
                              //
                            ],
                          ), //end of the row that shows the visit purpose options

                          // section to capture maintenance details
                          maintenance == true
                              ? Container(
                                  margin: EdgeInsets.only(
                                      left: size.width * 0.03,
                                      right: size.width * 0.03,
                                      top: size.height * 0.008),
                                  height: size.height * 0.51,
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.contentColorPurple),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: size.height * 0.030,
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Maintenance products",
                                                    style: GoogleFonts.lato(
                                                        color: AppColors
                                                            .contentColorPurple)),
                                                SizedBox(
                                                  width: size.width * 0.02,
                                                ),
                                                IconButton(
                                                  //add a plus icon
                                                  icon: Icon(
                                                    Icons.add,
                                                    color: AppColors
                                                        .contentColorPurple,
                                                    size: size.width * 0.05,
                                                  ),
                                                  onPressed: () {
                                                    ModalUtils
                                                        .showSimpleModalDialog(
                                                            context,
                                                            productList,
                                                            isOrder: false);
                                                  },
                                                ),
                                              ]),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.030,
                                        ),
                                        // capturing date of maintenance
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.width * 0.03),
                                          child: TextFormField(
                                            controller: maintenanceDate,
                                            onTap: () => _selectDate(
                                                context, maintenanceDate),
                                            decoration: InputDecoration(
                                              labelText: 'Date of maintenance',
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
                                        //
                                        SizedBox(
                                          height: size.height * 0.030,
                                        ),
                                        // capturing comment related to  maintenance
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.width * 0.03),
                                          child: TextFormField(
                                            controller: maintenanceComment,
                                            maxLines: 7,
                                            minLines: 5,
                                            decoration: InputDecoration(
                                              labelText: 'maintenance comment',
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
                                        //
                                        // in this section we have to capture also various data ie to be captured inside the column

                                        // --- the above that to be sent to an api end point --- //
                                        //
                                        // end of section to capture sales input fields on sales section
                                        SizedBox(
                                          height: size.height * 0.020,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.width * 0.03),
                                          child: TextFormField(
                                            controller: visitNotesController,
                                            maxLines:
                                                7, // Set the maximum number of lines
                                            minLines: 5,
                                            decoration: InputDecoration(
                                              labelText: 'visit notes',
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
                                        SizedBox(
                                          height: size.height * 0.025,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(),
                          // end section to capture maintenance details

                          // section to capture demo input field on demo section
                          demo == true
                              ? Container(
                                  margin: EdgeInsets.only(
                                      left: size.width * 0.03,
                                      right: size.width * 0.03,
                                      top: size.height * 0.008),
                                  height: size.height * 0.48,
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.contentColorPurple),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: size.height * 0.030,
                                        ),
                                        // capturing date of maintenance
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.width * 0.03),
                                          child: TextFormField(
                                            controller: demoDate,
                                            onTap: () =>
                                                _selectDate(context, demoDate),
                                            decoration: InputDecoration(
                                              labelText: 'Demo date',
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
                                        //
                                        SizedBox(
                                          height: size.height * 0.030,
                                        ),
                                        // capturing comment related to  maintenance
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.width * 0.03),
                                          child: TextFormField(
                                            controller: demoNotes,
                                            maxLines:
                                                7, // Set the maximum number of lines
                                            minLines: 5,
                                            decoration: InputDecoration(
                                              labelText: 'record demo notes',
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
                                        // in this section we have to capture also the
                                        // user id
                                        //  business id
                                        // visit id
                                        // --- the above that to be sent to an api end point --- //
                                        //
                                        // end of section to capture sales input fields on sales section
                                        SizedBox(
                                          height: size.height * 0.020,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.width * 0.03),
                                          child: TextFormField(
                                            controller: visitNotesController,
                                            maxLines:
                                                7, // Set the maximum number of lines
                                            minLines: 5,
                                            decoration: InputDecoration(
                                              labelText: 'visit notes',
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
                                        SizedBox(
                                          height: size.height * 0.025,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(),
                          // eend of section to capture demo input field on demo section

                          // section to capture delivery input fields on delivery section
                          delivery == true
                              ? Container(
                                  margin: EdgeInsets.only(
                                      left: size.width * 0.03,
                                      right: size.width * 0.03,
                                      top: size.height * 0.008),
                                  // height: size.height*0.45,
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.contentColorPurple),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      children: [
                                        SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Column(children: [
                                            Text(
                                              "Click \t'+'\t to add/edit products",
                                              style: GoogleFonts.lato(
                                                color: AppColors
                                                    .contentColorPurple
                                                    .withOpacity(0.4),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("Products delivered",
                                                        style: GoogleFonts.lato(
                                                            color: AppColors
                                                                .contentColorPurple)),
                                                    SizedBox(
                                                      width: size.width * 0.02,
                                                    ),
                                                    IconButton(
                                                      //add a plus icon
                                                      icon: Icon(
                                                        Icons.add,
                                                        color: AppColors
                                                            .contentColorPurple,
                                                        size: size.width * 0.05,
                                                      ),
                                                      onPressed: () {
                                                        ModalUtils
                                                            .showSimpleModalDialog(
                                                                context,
                                                                productList,
                                                                isOrder: true);
                                                      },
                                                    ),
                                                  ]),
                                            ),
                                          ]),
                                        ),
                                        // in this section we have to capture also the
                                        // user id
                                        //  business id
                                        // visit id
                                        // --- the above that to be sent to an api end point --- //
                                        //
                                        // end of section to capture sales input fields on sales section
                                        SizedBox(
                                          height: size.height * 0.020,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.width * 0.03),
                                          child: TextFormField(
                                            controller: visitNotesController,
                                            maxLines:
                                                7, // Set the maximum number of lines
                                            minLines: 5,
                                            decoration: InputDecoration(
                                              labelText: 'visit notes',
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
                                        SizedBox(
                                          height: size.height * 0.025,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(), //  end of section to capture delivery input fields on delivery section
                          // section to cpature appointment input fields on appointment section
                          appointment == true
                              ? Container(
                                  margin: EdgeInsets.only(
                                      left: size.width * 0.03,
                                      right: size.width * 0.03,
                                      top: size.height * 0.008),
                                  height: size.height * 0.48,
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.contentColorPurple),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: size.height * 0.030,
                                        ),
                                        // capturing date of maintenance
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.width * 0.03),
                                          child: TextFormField(
                                            controller: appointmentDate,
                                            onTap: () => _selectDate(
                                                context, appointmentDate),
                                            decoration: InputDecoration(
                                              labelText: 'Meeting date',
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
                                        //
                                        SizedBox(
                                          height: size.height * 0.030,
                                        ),
                                        // capturing comment related to  maintenance
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.width * 0.03),
                                          child: TextFormField(
                                            controller: startTimeController,
                                            decoration: InputDecoration(
                                              labelText: 'Meeting start time',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                borderSide: const BorderSide(
                                                    color: Colors
                                                        .blue), // Change the border color here
                                              ),
                                              suffixIcon: IconButton(
                                                icon: const Icon(
                                                    Icons.access_time),
                                                onPressed: () => _selectTime(
                                                    context,
                                                    startTimeController),
                                              ),
                                            ),
                                            keyboardType:
                                                TextInputType.datetime,
                                          ),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.030,
                                        ),
                                        // capturing comment related to  maintenance
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.width * 0.03),
                                          child: TextFormField(
                                            controller: endTimeController,
                                            decoration: InputDecoration(
                                              labelText: 'Meeting end time',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                borderSide: const BorderSide(
                                                    color: Colors
                                                        .blue), // Change the border color here
                                              ),
                                              suffixIcon: IconButton(
                                                icon: const Icon(
                                                    Icons.access_time),
                                                onPressed: () => _selectTime(
                                                    context, endTimeController),
                                              ),
                                            ),
                                            keyboardType: TextInputType
                                                .datetime, // Set the keyboard input type to datetime
                                          ),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.030,
                                        ),
                                        // capturing comment related to  maintenance
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.width * 0.03),
                                          child: TextFormField(
                                            controller: appointmentNotes,
                                            maxLines:
                                                7, // Set the maximum number of lines
                                            minLines:
                                                5, // Set the minimum number of lines
                                            decoration: InputDecoration(
                                              labelText:
                                                  'Capture meeting notes',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                borderSide: const BorderSide(
                                                    color: Colors
                                                        .blue), // Change the border color here
                                              ),
                                            ),
                                          ),
                                        ),
                                        // in this section we have to capture also the
                                        // user id
                                        //  business id
                                        // visit id
                                        // --- the above that to be sent to an api end point --- //
                                        //
                                        // end of section to capture sales input fields on sales section
                                        SizedBox(
                                          height: size.height * 0.020,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.width * 0.03),
                                          child: TextFormField(
                                            controller: visitNotesController,
                                            maxLines:
                                                7, // Set the maximum number of lines
                                            minLines: 5,
                                            decoration: InputDecoration(
                                              labelText: 'visit notes',
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
                                        SizedBox(
                                          height: size.height * 0.025,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(),
                          //  end of section to capture appointment input fields on appointment section
                          // section to capture sales input fields on sales section
                          sales == true
                              ? Container(
                                  margin: EdgeInsets.only(
                                      left: size.width * 0.03,
                                      right: size.width * 0.03,
                                      top: size.height * 0.008),
                                  // height: size.height*0.45,
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.contentColorPurple),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      children: [
                                        SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Column(children: [
                                            Text(
                                              "Click \t'+'\t to add/edit products",
                                              style: GoogleFonts.lato(
                                                color: AppColors
                                                    .contentColorPurple
                                                    .withOpacity(0.4),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("Products Sold",
                                                        style: GoogleFonts.lato(
                                                            color: AppColors
                                                                .contentColorPurple)),
                                                    SizedBox(
                                                      width: size.width * 0.02,
                                                    ),
                                                    IconButton(
                                                      //add a plus icon
                                                      icon: Icon(
                                                        Icons.add,
                                                        color: AppColors
                                                            .contentColorPurple,
                                                        size: size.width * 0.05,
                                                      ),
                                                      onPressed: () {
                                                        ModalUtils
                                                            .showSimpleModalDialog(
                                                                context,
                                                                productList,
                                                                isOrder: true);
                                                      },
                                                    ),
                                                  ]),
                                            ),
                                          ]),
                                        ),
                                        // in this section we have to capture also the
                                        // user id
                                        //  business id
                                        // visit id
                                        // --- the above that to be sent to an api end point --- //
                                        //
                                        // end of section to capture sales input fields on sales section
                                        SizedBox(
                                          height: size.height * 0.020,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.width * 0.03),
                                          child: TextFormField(
                                            controller: visitNotesController,
                                            maxLines:
                                                7, // Set the maximum number of lines
                                            minLines: 5,
                                            decoration: InputDecoration(
                                              labelText: 'visit notes',
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
                                        SizedBox(
                                          height: size.height * 0.025,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(),
                          SizedBox(
                            height: size.height * 0.020,
                          ),
                          showRecordButton()
                              ? Center(
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
                                        'Record a visit',
                                        style: GoogleFonts.lato(
                                          fontSize: size.width * 0.035,
                                          color: AppColors.contentColorPurple,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  margin:
                                      EdgeInsets.only(top: size.height * 0.02),
                                  child: Center(
                                    child: Text(
                                      "Select a visit purpose to record a visit",
                                      style: GoogleFonts.lato(
                                        fontSize: size.width * 0.035,
                                        color: AppColors.contentColorPurple,
                                      ),
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: size.height * 0.025,
                          ),
                          //
                        ],
                      ))
                      //
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  //
// function for automatically picking the date
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
  // fucntion for automatically picking the time
  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != TimeOfDay.now()) {
      setState(() {
        controller.text = picked.format(context);
      });
    }
  }

  bool showRecordButton() {
    if (maintenance == true) {
      return true;
    }
    if (demo == true) {
      return true;
    }
    if (delivery == true) {
      return true;
    }
    if (appointment == true) {
      return true;
    }
    if (sales == true) {
      return true;
    }
    return false;
  }
}
