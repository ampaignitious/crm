import 'dart:developer';

import 'package:vfu/Controllers/services.dart';
import 'package:vfu/Models/User.dart';
import 'package:vfu/Screens/ArrearPage.dart';
import 'package:vfu/Screens/AuthenticationSceens/LoginScreen.dart';
import 'package:vfu/Screens/CalculatorPage.dart';
import 'package:vfu/Screens/CommentsPage.dart';
import 'package:vfu/Screens/DefaultScreen.dart';
import 'package:vfu/Screens/ExpectedRepayments.dart';
import 'package:vfu/Screens/IncentivePage.dart';
import 'package:vfu/Screens/SalesTrackerPage.dart';

import 'package:vfu/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerItems extends StatefulWidget {
  const DrawerItems({super.key});

  @override
  State<DrawerItems> createState() => _DrawerItemsState();
}

class _DrawerItemsState extends State<DrawerItems> {
  late User user;
  late Future<void> userFuture;

  Future<User> getUser() async {
    try {
      AuthController authController = AuthController();
      User response = await authController.getUserDetails();
      log("user details: $response");
      if (response.status == 'success') {
        return response;
      } else {
        log("no success in user details: $response");
        return User(
          name: 'Error',
          username: 'Error',
          staffId: 'Error',
          userType: 'Error',
          regionId: 'Error',
          branchId: 'Error',
          status: 'Error',
        );
      }
    } catch (e) {
      log("user error: $e");
      return User(
        name: 'Error',
        username: 'Error',
        staffId: 'Error',
        userType: 'Error',
        regionId: 'Error',
        branchId: 'Error',
        status: 'Error',
      );
    }
  }

  Future<void> signOut() async {
    AuthController authController = AuthController();

    final response = await authController.signOut();

    if (response['status'] == 'success') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const LoginScreen();
      }));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Logout Failed"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    userFuture = getUser();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: userFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          //wait to open the drawer until data is fetched
          return const Drawer(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          // Show error message if there's an error during data fetching
          return Text('Error: ${snapshot.error}');
        } else {
          // User data is available, build the drawer
          final User user = snapshot.data as User;
          return Drawer(
            width: size.width * 0.9,
            child: Drawer(
              child: ListView(
                children: [
                  DrawerHeader(
                    margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColors.contentColorPurple.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors
                          .contentColorCyan, // Adjust the background color of the drawer header
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Text(
                                  user.name,
                                  style: GoogleFonts.lato(
                                      fontSize: size.width * 0.04,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.012,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.app_registration,
                                color: AppColors.contentColorPurple,
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: size.width * 0.03),
                                  child: Text(user.name),
                                ),
                              )
                            ],
                          ),
                          const Divider(),
                          Row(
                            children: [
                              const Icon(
                                Icons.perm_identity,
                                color: AppColors.contentColorPurple,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: size.width * 0.03),
                                child: Text(user.staffId),
                              )
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.4,
                          ),
                        ],
                      ),
                    ),
                    // ... other header content ...
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const DefaultScreen();
                      }));
                    },
                    child: const Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.home,
                          color: AppColors
                              .contentColorPurple, // Change the color of the drawer icon here
                        ),
                        title: Text('Dashboard'),
                      ),
                    ),
                  ),
                  //
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const ArrearPage();
                      }));
                    },
                    child: const Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.person,
                          color: AppColors
                              .contentColorPurple, // Change the color of the drawer icon here
                        ),
                        title: Text('Arrears'),
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const SalesTrackerPage();
                      }));
                    },
                    child: const Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.store,
                          color: AppColors
                              .contentColorPurple, // Change the color of the drawer icon here
                        ),
                        title: Text('Sales Tracker'),
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const CalculatorPage();
                      }));
                    },
                    child: const Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.calculate,
                          color: AppColors
                              .contentColorPurple, // Change the color of the drawer icon here
                        ),
                        title: Text('Loan Calculator'),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const ExpectedRepayments();
                      }));
                    },
                    child: const Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.monitor_weight,
                          color: AppColors
                              .contentColorPurple, // Change the color of the drawer icon here
                        ),
                        title: Text('Expected Repayments'),
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const CommentsPage();
                      }));
                    },
                    child: const Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.insert_comment,
                          color: AppColors
                              .contentColorPurple, // Change the color of the drawer icon here
                        ),
                        title: Text('Comments'),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const IncentivePage();
                      }));
                    },
                    child: const Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.location_on,
                          color: AppColors
                              .contentColorPurple, // Change the color of the drawer icon here
                        ),
                        title: Text('Incentives'),
                      ),
                    ),
                  ),

                  //drawer footer
                  InkWell(
                    onTap: () {
                      signOut();
                    },
                    child: const Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.logout,
                          color: AppColors
                              .contentColorPurple, // Change the color of the drawer icon here
                        ),
                        title: Text('Logout'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
