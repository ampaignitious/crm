import 'package:valour/Controllers/services.dart';
import 'package:valour/Models/Coffee.dart';
import 'package:valour/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valour/Widgets/SalesScreenWidgets/AvailableCoffeeProductsDisplayScreen.dart';

enum FormMode {
  Add,
  Edit,
}

class CoffeeProductRegistrationFrom extends StatefulWidget {
  final Coffee? coffee;
  final FormMode formMode;
  const CoffeeProductRegistrationFrom({super.key, this.coffee, required this.formMode});

  @override
  State<CoffeeProductRegistrationFrom> createState() =>
      _CoffeeProductRegistrationFromState();
}

class _CoffeeProductRegistrationFromState
    extends State<CoffeeProductRegistrationFrom> {
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

  List<String> coffeeUnits = [
    'Kg',
    'g',
  ];

  late String selectedCategory;
  late String selectedUnit;

  Future<void> addProduct() async {
    Map<String, dynamic> body = {
      "product_name": productName.text,
      "price": productPrice.text,
      "quantity": productQuantity.text,
      "description": productDescription.text,
      "type": "coffee_product",
      "unit": selectedUnit,
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
      "type": "coffee_product",
      "unit": selectedUnit,
      "category": selectedCategory,
    };
    print("body: $body");
    AuthController authController = AuthController();
    final response = await authController.updateProduct(widget.coffee!.id, body);
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
          Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const AvailableCoffeeProductsDisplayScreen();
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

  void saveForm(){
    if(widget.formMode == FormMode.Add){
      addProduct();
    }
    else{
      updateProduct();
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.formMode == FormMode.Edit) {
      productName.text = widget.coffee!.productName;
      productPrice.text = widget.coffee!.productPrice.toString();
      productQuantity.text = widget.coffee!.productQuantity.toString();
      productDescription.text = widget.coffee!.description;
      selectedCategory = widget.coffee!.productCategory;
      selectedUnit = widget.coffee!.unit;
    } else {
      selectedCategory = coffeeCategories[0];
      selectedUnit = coffeeUnits[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    print("selectedCategory: $selectedCategory");
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
            widget.formMode == FormMode.Add
                ? "Add Coffee Product"
                : "Edit Coffee Product",
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
        margin:
            EdgeInsets.only(left: size.width * 0.01, top: size.height * 0.004),
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
                        labelText: "Enter coffee name",
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
                        labelText: 'Select coffee category',
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
                    child: DropdownButtonFormField(
                      value: selectedUnit,
                      items: coffeeUnits.map((String unit) {
                        return DropdownMenuItem(
                          value: unit,
                          child: Text(unit),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        if (value != null) {
                          setState(() {
                            selectedUnit = value;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Select Unit',
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
                        labelText: "coffee product price",
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
                        labelText: "coffee product quantity",
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
                        labelText: "coffee product description",
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
                          widget.formMode == FormMode.Add
                              ? "Add Product"
                              : "Update Product",
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
      ),
    );
  }
}
