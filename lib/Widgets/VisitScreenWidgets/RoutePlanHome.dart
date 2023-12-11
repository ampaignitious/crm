import 'package:valour/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:valour/Widgets/VisitScreenWidgets/CreateRoutePlan.dart';

class RoutePlanHome extends StatefulWidget {
  const RoutePlanHome({super.key});

  @override
  State<RoutePlanHome> createState() => _RoutePlanHomeState();
}

class _RoutePlanHomeState extends State<RoutePlanHome> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.030,
          ),
          Center(
            child: Container(
              height: size.height * 0.33,
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
                  SizedBox(
                    height: size.height * 0.018,
                  ),
                  Row(
                    children: [
                      Lottie.asset(
                        'assets/json/routeplan.json', // Path to your Lottie animation JSON file
                        width: size.width * 0.43, // Adjust width as needed
                        height: size.height * 0.18,
                        fit: BoxFit.fill,
                      ),
                      // this container displays stats on the add a visit container display section
                      Container(
                        height: size.height * 0.19,
                        width: size.width * 0.499,
                        decoration: BoxDecoration(
                          color: AppColors.contentColorCyan,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              offset: const Offset(0.8, 1.0),
                              blurRadius: 4.0,
                              spreadRadius: 0.2,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: size.height * 0.015,
                              ),
                              Center(
                                child: Text(
                                  "route plan statistics",
                                  style: GoogleFonts.lato(
                                    fontSize: size.width * 0.038,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.contentColorPurple,
                                  ),
                                ),
                              ),
                              const Divider(
                                thickness: 1,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: size.width * 0.03),
                                child: Text(
                                  "Pending route plans: 456",
                                  style: GoogleFonts.lato(
                                    fontSize: size.width * 0.03,
                                    color: AppColors.contentColorBlack,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.015,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: size.width * 0.03),
                                child: Text(
                                  "Accompolished route plans: 120",
                                  style: GoogleFonts.lato(
                                    fontSize: size.width * 0.03,
                                    color: AppColors.contentColorBlack,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.019,
                              ),
                              Center(
                                child: Text(
                                  "Total route plans: 120",
                                  style: GoogleFonts.lato(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width * 0.038,
                                    color: AppColors.contentColorBlack,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      //
                    ],
                  ),
                  //
                  SizedBox(
                    height: size.height * 0.018,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const CreateRoutePlan();
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors
                          .contentColorPurple, // Set button color to purple
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.22,
                        vertical: size.height * 0.028,
                      ),
                      child: const Text('create a route plan'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.030,
          ),
          
          // second container
          SizedBox(
            height: size.height * 0.030,
          ),
        ],
      ),
    );
  }
}
