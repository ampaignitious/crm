import 'package:crm/Utils/AppColors.dart';
import 'package:crm/Widgets/SalesScreenWidgets/ProductSalesForm.dart';
import 'package:crm/Widgets/SalesScreenWidgets/SalesProcedure.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ProductSaleScreen extends StatefulWidget {
  const ProductSaleScreen({super.key});

  @override
  State<ProductSaleScreen> createState() => _ProductSaleScreenState();
}

class _ProductSaleScreenState extends State<ProductSaleScreen> with TickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(
        color: AppColors.contentColorPurple,
        size: size.width*0.08,
        ),  // Change the icon color here
        elevation: 0.6,
        backgroundColor: AppColors.contentColorCyan,
 
        title: Padding(
          padding: EdgeInsets.only(left: size.width*0.06),
          child: Text("product sales page",
           style: GoogleFonts.lato(
            fontSize: size.width*0.04, 
            color: AppColors.menuBackground,
            fontWeight: FontWeight.bold
          ),),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: size.width*0.03,
            ),
            child: Lottie.asset(
            'assets/json/notification.json', // Path to your Lottie animation JSON file
            width: size.width*0.16, // Adjust width as needed
            height: size.height*0.14,  
            fit: BoxFit.fill,
              ),
          ),
        ],
        bottom: TabBar(
          indicatorColor: AppColors.contentColorPurple.withOpacity(0.5),
          controller: _tabController,
          tabs: [
            Tab(
              child: Row(children: [
                Icon(Icons.event_sharp,
                size:size.height*0.014,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: size.width*0.008
                  ),
                  child: Text("product sales form", style: GoogleFonts.lato(
                    fontSize: size.height*0.014,
                    color: AppColors.darkRoast
                  ),),
                ),
              ]),
            ),
             Tab(
              child: Row(children: [
                Icon(Icons.event_sharp,
                size:size.height*0.014,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: size.width*0.008
                  ),
                  child: Text("product sale procedure", style: GoogleFonts.lato(
                    fontSize: size.height*0.014,
                    color: AppColors.darkRoast
                  ),),
                ),
              ]),
            ),
          ]
       )
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ProductSalesForm(),
          SalesProcedure()
          // ViewRoutePlans(),
        ],
      ),
    );
  }
}