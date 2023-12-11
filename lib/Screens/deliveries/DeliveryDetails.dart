import 'package:valour/Models/Delivery.dart';
import 'package:valour/Models/Product.dart';
import 'package:valour/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeliveryDetails extends StatefulWidget {
  final DeliveryData? delivery;
  const DeliveryDetails({super.key, required this.delivery});

  @override
  DeliveryDetailsState createState() => DeliveryDetailsState();
}

class DeliveryDetailsState extends State<DeliveryDetails> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
            appBar: AppBar(
        iconTheme: IconThemeData(
        color: AppColors.contentColorPurple,
        size: size.width*0.08,
        ),  // Change the icon color here
        elevation: 0,
        backgroundColor: AppColors.contentColorCyan,
 
        title: Padding(
          padding: EdgeInsets.only(left: size.width*0.03),
          child: Text("Delivery Details",
           style: GoogleFonts.lato(
            fontSize: size.width*0.038,
            color: AppColors.menuBackground,
            fontWeight: FontWeight.bold
          ),),
        ),
 
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildBusinessInformationSection(size),
          ],
        ),
      ),
    );
  }

  Widget _buildBusinessInformationSection(Size size) {
    return Padding(
      padding: EdgeInsets.only(
          left: size.width * 0.06,
          top: size.height * 0.04,
          bottom: size.height * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader("BUSINESS INFORMATION", size),
          SizedBox(height: size.height * 0.02),
          _buildInfoRow("Business Name", widget.delivery?.businessName ?? '',
              size, Icons.business),
          SizedBox(height: size.height * 0.02),
          _buildSectionHeader("DELIVERY PRODUCTS", size),
        _buildDeliveryProducts(size), // Display Delivery products here
          SizedBox(height: size.height * 0.02),
          _buildInfoRow(
              "Visit Notes",
              widget.delivery?.visitNotes ?? '',
              size,
              Icons.notes_outlined),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, Size size) {
    return Text(
      title,
      style: GoogleFonts.lato(
        fontSize: size.width * 0.05,
        color: const Color.fromARGB(255, 30, 14, 34),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildInfoRow(
      String label, String value, Size size, IconData iconData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.lato(
            fontSize: size.width * 0.04,
            color: Colors.black.withOpacity(0.6),
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            Icon(iconData), // Use the provided iconData parameter
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                value,
                style: GoogleFonts.lato(
                  fontSize: size.width * 0.04,
                  color: Colors.black.withOpacity(0.6),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDeliveryProducts(Size size) {
  final List<Product> deliveryProducts =
      widget.delivery?.deliveryProducts ?? [];

      print("Delivery Products: $deliveryProducts");

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: deliveryProducts.map((product) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader("Product Name", size),
          _buildInfoRow("Name", product.product_name, size, Icons.shopping_bag),
          SizedBox(height: size.height * 0.02),
        ],
      );
    }).toList(),
  );
}


}