import 'package:valour/Controllers/services.dart';
import 'package:valour/Models/Coffee.dart';
import 'package:valour/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:valour/Widgets/InventoryWidgets/CoffeeProductRegistrationForm.dart';

class AvailableCoffeeProductsDisplayScreen extends StatefulWidget {
  const AvailableCoffeeProductsDisplayScreen({super.key});

  @override
  State<AvailableCoffeeProductsDisplayScreen> createState() =>
      _AvailableCoffeeProductsDisplayScreenState();
}

class _AvailableCoffeeProductsDisplayScreenState
    extends State<AvailableCoffeeProductsDisplayScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<Coffee>> coffeeProducts;
  List<Coffee> coffeePro = [];
  @override
  void initState() {
    super.initState();
    coffeeProducts = getCoffeeProducts();
    _tabController = TabController(length: 1, vsync: this);
  }

  Future<List<Coffee>> getCoffeeProducts() async {
    AuthController authController = AuthController();
    try {
      final response = await authController.getCoffeeProducts();
      if (response.containsKey("error")) {
        throw Exception("The return is an error");
      } else {
        if (response['data'] != null) {
          List<dynamic> eventsData = response['data'];
          List<Coffee> events = eventsData.map((contactData) {
            return Coffee(
              id: contactData['id'],
              productName: contactData['product_name'] ?? "",
              productPrice: contactData['price'] ?? "",
              productQuantity: contactData['quantity'] ?? "",
              productCategory: contactData['category'] ?? "",
              description: contactData['description'] ?? "",
              unit: contactData['unit'] ?? "",
            );
          }).toList();
          return events;
        } else {
          // Handle the case where the 'contacts' field in the API response is null
          throw Exception("No data found");
        }
      }
    } catch (error) {
      print("Error: $error");
      // Handle the case where the 'contacts' field in the API response is null
      throw Exception("Un expected error occurred");
    }
  }

  Future<void> deleteCoffeeProduct(int product_id, int index) async {
    AuthController authController = AuthController();
    try {
      final response = await authController.deleteProduct(product_id);
      if (response.containsKey("error")) {
        // Handle error case
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response['error'],
              style: GoogleFonts.lato(
                fontSize: MediaQuery.of(context).size.width * 0.04,
                color: AppColors.contentColorWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: AppColors.contentColorRed,
          ),
        );
      } else {
        // Remove the deleted product from the local list
        setState(() {
          coffeePro.removeAt(index);
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Product deleted successfully",
              style: GoogleFonts.lato(
                fontSize: MediaQuery.of(context).size.width * 0.04,
                color: AppColors.contentColorWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: AppColors.contentColorGreen,
          ),
        );
      }
    } catch (error) {
      // Handle error case
      print("Error: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Unexpected error occurred",
            style: GoogleFonts.lato(
              fontSize: MediaQuery.of(context).size.width * 0.04,
              color: AppColors.contentColorWhite,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: AppColors.contentColorRed,
        ),
      );
    }
  }

  Future<void> updateProductQuantity(
      int product_id, int newQuantity, int index) async {
    AuthController authController = AuthController();
    try {
      final response = await authController.updateQuantityProduct(
        product_id,
        {"quantity": newQuantity},
      );
      if (response.containsKey("error")) {
        // Handle error case
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response['error'],
              style: GoogleFonts.lato(
                fontSize: MediaQuery.of(context).size.width * 0.04,
                color: AppColors.contentColorWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: AppColors.contentColorRed,
          ),
        );
      } else {
        setState(() {
          coffeePro[index].productQuantity = response['data']['quantity'];
        });
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Product quantity updated successfully",
              style: GoogleFonts.lato(
                fontSize: MediaQuery.of(context).size.width * 0.04,
                color: AppColors.contentColorWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: AppColors.contentColorGreen,
          ),
        );
      }
    } catch (error) {
      // Handle error case
      print("Error: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Unexpected error occurred",
            style: GoogleFonts.lato(
              fontSize: MediaQuery.of(context).size.width * 0.04,
              color: AppColors.contentColorWhite,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: AppColors.contentColorRed,
        ),
      );
    }
  }

  // Inside your _AvailableMachineDisplayScreenState class
  Future<void> showUpdateQuantityDialog(
      int productId, int currentQuantity, int index) async {
    int newQuantity = currentQuantity;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Product Quantity'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Current Quantity: $currentQuantity'),
              TextField(
                onChanged: (value) {
                  newQuantity = (int.tryParse(value)) ?? currentQuantity;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'New Quantity'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Call the method to update the quantity in the backend
                updateProductQuantity(productId, newQuantity, index);

                // Close the dialog
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

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
              "Coffee Products",
              style: GoogleFonts.lato(
                  fontSize: size.width * 0.05,
                  color: AppColors.menuBackground,
                  fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(
                right: size.width * 0.03,
              ),
              child: Lottie.asset(
                'assets/json/notification.json', // Path to your Lottie animation JSON file
                width: size.width * 0.16, // Adjust width as needed
                height: size.height * 0.14,
                fit: BoxFit.fill,
              ),
            ),
          ],
          bottom: TabBar(
              indicatorColor: AppColors.contentColorPurple.withOpacity(0),
              controller: _tabController,
              tabs: [
                Tab(
                  child: Row(children: [
                    Icon(
                      Icons.event_sharp,
                      size: size.height * 0.014,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: size.width * 0.008),
                      child: Text(
                        "Available coffee catergories: 20",
                        style: GoogleFonts.lato(
                            fontSize: size.height * 0.014,
                            color: AppColors.darkRoast),
                      ),
                    ),
                  ]),
                ),
              ])),
      body: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          FutureBuilder<List<Coffee>>(
            future: coffeeProducts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Display a loading indicator while waiting for the data.
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // Handle errors.
                return Text('Error: ${snapshot.error}');
              } else {
                // Data has been loaded successfully. Use it in the ListView.builder.
                coffeePro = snapshot.data!;
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: size.width * 0.03,
                          right: size.width * 0.03,
                          top: size.width * 0.03,
                          bottom: size.width * 0.010),
                      child: TextField(
                        // controller: searchController,
                        onChanged: (value) {
                          // filterVisitData(value);
                        },
                        decoration: InputDecoration(
                          labelText: 'Search the machine by name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: AppColors
                                    .contentColorPurple), // Change the border color here
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.7,
                      width: double.maxFinite,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: coffeePro.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Center(
                                child: Container(
                                    height: size.height * 0.25,
                                    width: size.width * 0.95,
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
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.03,
                                              right: size.width * 0.03,
                                              top: size.width * 0.03,
                                              bottom: size.width * 0.010),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  coffeePro[index].productName,
                                                  style: GoogleFonts.lato(
                                                      fontSize:
                                                          size.width * 0.07,
                                                      color: AppColors
                                                          .contentColorPurple,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Text(
                                                "${coffeePro[index].productPrice.toString()}/= per ${coffeePro[index].unit}",
                                                style: GoogleFonts.lato(
                                                    fontSize: size.width * 0.03,
                                                    color: AppColors.darkRoast,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.03,
                                              right: size.width * 0.03,
                                              top: size.width * 0.03,
                                              bottom: size.width * 0.010),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                coffeePro[index]
                                                    .productCategory,
                                                style: GoogleFonts.lato(
                                                    fontSize: size.width * 0.05,
                                                    color: AppColors.darkRoast,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "Qty: ${coffeePro[index].productQuantity.toString()}",
                                                style: GoogleFonts.lato(
                                                    fontSize: size.width * 0.05,
                                                    color: AppColors.darkRoast,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.03,
                                              right: size.width * 0.03,
                                              top: size.width * 0.03,
                                              bottom: size.width * 0.010),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  coffeePro[index].description,
                                                  style: GoogleFonts.lato(
                                                      fontSize:
                                                          size.width * 0.03,
                                                      color:
                                                          AppColors.darkRoast,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.03,
                                              right: size.width * 0.03,
                                              top: size.width * 0.03,
                                              bottom: size.width * 0.010),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              //add delete and edit buttons here
                                              IconButton(
                                                  onPressed: () async {
                                                    await deleteCoffeeProduct(
                                                        coffeePro[index].id,
                                                        index);
                                                  },
                                                  icon:
                                                      const Icon(Icons.delete)),

                                              //update quantity
                                              IconButton(
                                                  onPressed: () {
                                                    showUpdateQuantityDialog(
                                                        coffeePro[index].id,
                                                        coffeePro[index]
                                                            .productQuantity,
                                                        index);
                                                  },
                                                  icon: const Icon(Icons
                                                      .add_circle_outline)),

                                              IconButton(
                                                  onPressed: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return CoffeeProductRegistrationFrom(
                                                          coffee:
                                                              coffeePro[index],
                                                          formMode:
                                                              FormMode.Edit);
                                                    }));
                                                  },
                                                  icon: const Icon(Icons.edit)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
