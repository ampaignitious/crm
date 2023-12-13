import 'package:valour/Controllers/services.dart';
import 'package:valour/Models/Machine.dart';
import 'package:valour/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valour/Widgets/SalesScreenWidgets/AvailableMachinesDisplayScreen.dart';

enum MachineFormMode {
  Add,
  Edit,
}

class MachineRegistrationScreen extends StatefulWidget {
  final Machine? machine;
  final MachineFormMode machineFormMode;

  const MachineRegistrationScreen(
      {super.key, this.machine, required this.machineFormMode});

  @override
  State<MachineRegistrationScreen> createState() =>
      _MachineRegistrationScreenState();
}

class _MachineRegistrationScreenState extends State<MachineRegistrationScreen> {
  TextEditingController productName = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  TextEditingController productQuantity = TextEditingController();
  TextEditingController productDescription = TextEditingController();
  TextEditingController productType = TextEditingController();
  TextEditingController productCategory = TextEditingController();

  List<String> coffeeCategories = [
    'Category 1',
    'Category 2',
    'Category 3',
    'Category 4'
  ];

  late String selectedCategory = 'Category 1'; // Set a default category

  Future<void> addProduct() async {
    Map<String, dynamic> body = {
      "product_name": productName.text,
      "price": productPrice.text,
      "quantity": productQuantity.text,
      "description": productDescription.text,
      "type": "coffee_machine",
      "category": selectedCategory,
    };
    AuthController authController = AuthController();
    final response = await authController.addProduct(body);
    if (response.containsKey("error")) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Product registration failed"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Product registration successful"),
            backgroundColor: AppColors.contentColorYellow,
          ),
        );

        // Clear the text fields
        productName.clear();
        productPrice.clear();
        productQuantity.clear();
        productDescription.clear();
      }
    }
  }

  Future<void> updateProduct() async {
    Map<String, dynamic> body = {
      "product_name": productName.text,
      "price": productPrice.text,
      "quantity": productQuantity.text,
      "description": productDescription.text,
      "type": "coffee_machine",
      "category": selectedCategory,
    };
    print("body: $body");
    AuthController authController = AuthController();
    final response =
        await authController.updateProduct(widget.machine!.id, body);
    if (response.containsKey("error")) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Product update failed"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      if (context.mounted) {
        //navigate to AvailableMachineDisplayScreen
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const AvailableMachineDisplayScreen();
        }));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Product update successful"),
            backgroundColor: AppColors.contentColorGreen,
          ),
        );
      }
    }
  }

  void saveForm() {
    if (widget.machineFormMode == MachineFormMode.Add) {
      addProduct();
    } else {
      updateProduct();
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.machineFormMode == MachineFormMode.Edit) {
      productName.text = widget.machine!.productName;
      productPrice.text = widget.machine!.productPrice.toString();
      productQuantity.text = widget.machine!.productQuantity.toString();
      productDescription.text = widget.machine!.description;
      selectedCategory = widget.machine!.productCategory;
    } else {
      selectedCategory = coffeeCategories[0];
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
            padding: EdgeInsets.only(left: size.width * 0.06),
            child: Text(
              widget.machineFormMode == MachineFormMode.Add
                  ? "Add Machine"
                  : "Edit Machine",
              style: GoogleFonts.lato(
                  fontSize: size.width * 0.045,
                  color: AppColors.menuBackground,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Container(
          height: size.height * 0.9,
          width: size.width * 0.98,
          margin: EdgeInsets.only(
              left: size.width * 0.01, top: size.height * 0.004),
          decoration: BoxDecoration(
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
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.009,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.03),
                  child: Text(
                    "Enter the coffee product details",
                    style: GoogleFonts.lato(
                        fontSize: size.width * 0.045,
                        color: Colors.black.withOpacity(0.5)),
                  ),
                ),
                Form(
                    child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.018,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.03),
                      child: TextFormField(
                        controller: productName,
                        decoration: InputDecoration(
                          labelText: "Machine Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: AppColors
                                    .contentColorPurple), // Change the border color here
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.018,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.03),
                      child: DropdownButtonFormField(
                        value: selectedCategory,
                        items: coffeeCategories.map((String category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          if (value != null) {
                            setState(() {
                              selectedCategory = value;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Machine Category',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: AppColors.contentColorPurple,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.018,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.03),
                      child: TextFormField(
                        controller: productPrice,
                        decoration: InputDecoration(
                          labelText: "Price",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: AppColors
                                    .contentColorPurple), // Change the border color here
                          ),
                          // controller: _endDate,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.018,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.03),
                      child: TextFormField(
                        controller: productQuantity,
                        decoration: InputDecoration(
                          labelText: "Quantity",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: AppColors
                                    .contentColorPurple), // Change the border color here
                          ),
                          // controller: _endDate,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.018,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.03),
                      child: TextFormField(
                        controller: productDescription,
                        maxLines: 7,
                        minLines: 5,
                        decoration: InputDecoration(
                          labelText: "Description",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: AppColors
                                    .contentColorPurple), // Change the border color here
                          ),
                          // controller: _endDate,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.028,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          saveForm();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors
                              .contentColorYellow, // Set button color to purple
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.24,
                            vertical: size.height * 0.029,
                          ),
                          child: Text(
                            widget.machineFormMode == MachineFormMode.Add
                                ? "Add Machine"
                                : "Update Machine",
                            style: GoogleFonts.lato(
                                color: AppColors.contentColorPurple,
                                fontSize: size.width * 0.035),
                          ),
                        ),
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
        ));
  }
}
