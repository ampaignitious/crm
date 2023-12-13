import 'package:valour/Controllers/services.dart';
import 'package:valour/Models/User.dart';
import 'package:valour/Screens/AuthenticationSceens/LoginScreen.dart';
import 'package:valour/Screens/DefaultScreen.dart';
import 'package:valour/Screens/MainteanceScreen.dart';
import 'package:valour/Screens/ProfileScreen.dart';
 import 'package:valour/Screens/Targets.dart';
import 'package:valour/Screens/VisitsPage.dart';
import 'package:valour/Screens/appointments/index.dart';
import 'package:valour/Screens/contacts/index.dart';
import 'package:valour/Screens/deliveries/index.dart';
import 'package:valour/Screens/demos/index.dart';
import 'package:valour/Screens/sales/index.dart';
import 'package:valour/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:valour/Widgets/VisitScreenWidgets/RoutePlan.dart';

class DrawerItems extends StatefulWidget {
  const DrawerItems({super.key});

  @override
  State<DrawerItems> createState() => _DrawerItemsState();
}

class _DrawerItemsState extends State<DrawerItems> {
  User? user;
  late Future<void> userFuture;

  Future<void> getUser() async {
    AuthController authController = AuthController();

    final response = await authController.getProfile();
    //assign name and email from response to user object
    user = User(
        name: response['user']['name'] ?? "Full Name",
        email: response['user']['email'] ?? "User Email");

    setState(() {});
  }

  Future<void> signOut() async {
    AuthController authController = AuthController();

    final response = await authController.signOut();

    if (response['status'] == 'success') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return LoginScreen();
      }));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
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
          return Drawer(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          // Show error message if there's an error during data fetching
          return Text('Error: ${snapshot.error}');
        } else {
          // User data is available, build the drawer
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
                              InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ProfileScreen();
                                  }));
                                },
                                child: CircleAvatar(
                                  radius: size.width * 0.08,
                                  backgroundImage:
                                      AssetImage("assets/images/userimage.jpg"),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  user!.name,
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
                              Icon(
                                Icons.email,
                                color: AppColors.contentColorPurple,
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: size.width * 0.03),
                                  child: Text(user!.email),
                                ),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              const Icon(
                                Icons.phone,
                                color: AppColors.contentColorPurple,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: size.width * 0.03),
                                child: Text("07846740604"),
                              )
                            ],
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
                        title: Text('Home'),
                      ),
                    ),
                  ),
                  //
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const RoutePlan();
                      }));
                    },
                    child: const Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.location_on,
                          color: AppColors
                              .contentColorPurple, // Change the color of the drawer icon here
                        ),
                        title: Text('Route plan'),
                      ),
                    ),
                  ),
                  //
                  Card(
                    child: ListTile(
                      leading: Lottie.asset(
                        'assets/json/visits.json', // Path to your Lottie animation JSON file
                        width: size.width * 0.14, // Adjust width as needed
                        height: size.height * 0.16,
                        fit: BoxFit.fill,
                      ),
                      title: Text('Clients'),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return VisitsPage();
                        }));
                      },
                    ),
                  ),
                
                  //
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const Sale();
                      }));
                    },
                    child: Card(
                      child: ListTile(
                        leading: Lottie.asset(
                          'assets/json/sales.json', // Path to your Lottie animation JSON file
                          width: size.width * 0.14, // Adjust width as needed
                          height: size.height * 0.16,
                          fit: BoxFit.fill,
                        ),
                        title: const Text('Sales'),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const Sale();
                          }));
                        },
                      ),
                    ),
                  ),
                  //
                  Card(
                    child: ListTile(
                      leading: Lottie.asset(
                        'assets/json/target.json', // Path to your Lottie animation JSON file
                        width: size.width * 0.17, // Adjust width as needed
                        height: size.height * 0.05,
                        fit: BoxFit.fill,
                      ),
                      title: const Text('Targets'),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const Targets();
                        }));
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.settings,
                        color: AppColors
                            .contentColorPurple, // Change the color of the drawer icon here
                      ),
                      title: const Text('Maintenance'),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const MainteanceScreen();
                        }));
                      },
                    ),
                  ),
                    Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.settings,
                        color: AppColors
                            .contentColorPurple, // Change the color of the drawer icon here
                      ),
                      title: const Text('Demos'),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const Demo();
                        }));
                      },
                    ),
                  ),
                    Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.settings,
                        color: AppColors
                            .contentColorPurple, // Change the color of the drawer icon here
                      ),
                      title: const Text('Appointments'),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const Appointment();
                        }));
                      },
                    ),
                  ),
                    Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.settings,
                        color: AppColors
                            .contentColorPurple, // Change the color of the drawer icon here
                      ),
                      title: const Text('Deliveries'),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const Delivery();
                        }));
                      },
                    ),
                  ),
                    Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.settings,
                        color: AppColors
                            .contentColorPurple, // Change the color of the drawer icon here
                      ),
                      title: const Text('Contacts'),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const Contacts();
                        }));
                      },
                    ),
                  ),

                  Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.exit_to_app_rounded,
                        color: AppColors
                            .contentColorPurple, // Change the color of the drawer icon here
                      ),
                      title: const Text('Logout'),
                      onTap: () {
                        signOut();
                      },
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
