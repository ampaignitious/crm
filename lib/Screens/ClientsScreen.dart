import 'package:valour/Controllers/services.dart';
import 'package:valour/Models/Business.dart';
import 'package:valour/Screens/ProfileScreen.dart';
import 'package:valour/Utils/AppColors.dart';
import 'package:valour/Widgets/VisitScreenWidgets/CreateVisitScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
 TextEditingController searchController = TextEditingController();
  late Future<List<Business>> businesses;

  @override
  void initState() {
    super.initState();
    businesses = getMappings();
  }

  Future<List<Business>> getMappings() async {
    AuthController authController = AuthController();
    try {
      final response = await authController.getMappings();
      if (response.containsKey("error")) {
        throw Exception("The return is an error");
      } else {
        if (response['data'] != null) {
          List<dynamic> businessesData = response['data'];
          List<Business> businesss = businessesData.map((businessInfo) {
           return Business(
              id: businessInfo['id'],
              businessName: businessInfo['business_name'],
              pitchInterest: businessInfo['pitch_interest'],
              businessEmailContact:businessInfo['business_email_contact'],
              businessTelephoneContact: businessInfo['business_telephone_contact'],
              businessPhysicalAddress:businessInfo['physical_address'],
              businessContactPersonName:businessInfo['contact_person_name'],
              businessContactPersonTelephone:businessInfo['contact_person_telephone'],
              businessContactPersonGender:businessInfo['contact_person_gender'],
              businessDescription: businessInfo['notes'],
              businessContactPersonEmail: businessInfo['contact_person_email'],
            );
          }).toList();
          return businesss;
        } else {
          // Handle the case where the 'contacts' field in the API response is null
          throw Exception("No data found");
        }
      }
    } catch (error) {
      // Handle the case where the 'contacts' field in the API response is null
      throw Exception("Un expected error occurred");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var spacing = size.width * 0.14;
    var spacing2 = size.width * 0.03;
    var idwidth = size.width * 0.18;
    var idheight = size.height * 0.06;
    var visitwidth = size.width * 0.48;
    var descriptionwidth = size.width * 0.3;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            "Clients",
            style: GoogleFonts.lato(
                fontSize: size.width * 0.05,
                color: AppColors.menuBackground,
                fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          Row(
            children: [
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
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const ProfileScreen();
                  }));
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    right: size.width * 0.03,
                  ),
                  child: CircleAvatar(
                    backgroundImage:
                        const AssetImage("assets/images/userprofile.png"),
                    radius: size.width * 0.065,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.01,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.03,
                right: size.width * 0.03,
                top: size.width * 0.03,
                bottom: size.width * 0.010),
            child: TextField(
              controller: searchController,
              onChanged: (value) {},
              decoration: InputDecoration(
                labelText: 'search client by name',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                      color: AppColors
                          .contentColorPurple), // Change the border color here
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: size.width * 0.01, bottom: size.width * 0.03),
            child: Text(
              "Click on the item to see more information",
              style: GoogleFonts.lato(color: Colors.black.withOpacity(0.2)),
            ),
          ),
          Container(
            height: size.height * 0.06,
            width: double.maxFinite,
            decoration:
                const BoxDecoration(color: AppColors.contentColorPurple),
            child: Center(
              child: Row(
                children: [
                  Container(
                      height: size.height * 0.06,
                      width: size.width * 0.18,
                      decoration: const BoxDecoration(
                          color: AppColors.contentColorWhite),
                      child: Center(
                          child: Text(
                        "Id",
                        style: GoogleFonts.lato(),
                      ))),
                  Container(
                      // margin: EdgeInsets.only(left: size.width*0.01),
                      height: size.height * 0.06,
                      width: size.width * 0.5,
                      decoration: const BoxDecoration(
                        color: AppColors.contentColorYellow,
                      ),
                      child: Center(
                          child: Text(
                        "client's name",
                        style: GoogleFonts.lato(),
                      ))),
                  Container(
                      margin: EdgeInsets.only(left: size.width * 0.01),
                      height: size.height * 0.06,
                      width: size.width * 0.3,
                      decoration: const BoxDecoration(
                        color: AppColors.contentColorPurple,
                      ),
                      child: Center(
                          child: Text(
                        "Status",
                        style: GoogleFonts.lato(color: Colors.white),
                      )))
                ],
              ),
            ),
          ),
          FutureBuilder(
            future: businesses,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  //print the error
                  print("snapshot error: ${snapshot.error.toString()}");
                  return const Center(
                    child: Text("An error occurred"),
                  );
                } else if (snapshot.hasData) {
                  final data = snapshot.data as List<Business>;
                  return SizedBox(
                    height: size.height * 0.62,
                    width: double.maxFinite,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Business businessData = data[index];
                        return buildTableRowWidget(businessData, spacing, spacing2,
                            idwidth, idheight, visitwidth, descriptionwidth, businessData.id);
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: Text("No data"),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildTableRowWidget(
      Business businessData,
      double size1,
      double size2,
      double idwidth,
      double idheight,
      double visitwidth,
      double descriptionwidth, int businessId) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CreateVisitScreen(businessId: businessId);
        }));
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: size2),
          child: Row(
            children: [
              Container(
                height: idheight,
                width: idwidth,
                decoration: const BoxDecoration(
                    // color: AppColors.contentColorWhite,
                    ),
                child: Center(
                  child: Text(
                    businessData.id.toString(),
                    style: GoogleFonts.lato(),
                  ),
                ),
              ),
              Container(
                  height: idheight,
                  width: visitwidth,
                  decoration: const BoxDecoration(
                      // color: AppColors.contentColorYellow,
                      ),
                  child: Center(
                      child: Text(
                    businessData.businessName,
                    style: GoogleFonts.lato(),
                  ))),
              Container(
                  height: idheight,
                  width: descriptionwidth,
                  decoration: const BoxDecoration(
                      // color: AppColors.contentColorPurple,
                      ),
                  child: Center(
                      child: Text(
                    businessData.pitchInterest,
                    style: GoogleFonts.lato(color: Colors.black),
                    textAlign: TextAlign.center,
                  )))
            ],
          ),
        ),
      ),
    );
  }
}
