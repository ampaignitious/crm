import 'package:vfu/Utils/AppColors.dart';
import 'package:vfu/Widgets/Drawer/DrawerItems.dart';
import 'package:vfu/Widgets/HomeScreenWIdgets/ContainerDisplayingMenuItems.dart';
import 'package:vfu/Widgets/HomeScreenWIdgets/ContainerDisplayingStats.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: Drawer(
        backgroundColor: AppColors.contentColorOrange,
        width: size.width * 0.8,
        child: const DrawerItems(),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.contentColorOrange,
          size: size.width * 0.11,
        ), // Change the icon color here

        backgroundColor: AppColors.contentColorCyan,

        title: Text(
          "Dashboard",
          style: GoogleFonts.lato(
              fontSize: size.width * 0.062,
              color: AppColors.menuBackground,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          Row(
            children: [
              InkWell(
                onTap: () {},
                child: Padding(
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
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  //
                  Positioned.fill(
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.05), // Adjust opacity here
                        BlendMode.dstATop,
                      ),
                      child: Image.asset(
                        'assets/images/image1.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  //
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // container displaying statistics
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        const ContainerDisplayingStats(),
                        // Container displaying dashboard menu items
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        SizedBox(
                          height: size.height * 0.65,
                          width: double.maxFinite,
                          child: const SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: ContainerDisplayingMenuItems()),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
