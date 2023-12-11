 import 'package:valour/Utils/AppColors.dart';
import 'package:valour/Widgets/VisitScreenWidgets/SIngleVisitViewScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valour/Controllers/services.dart';
import 'package:valour/Models/Business.dart';

class ViewVisits extends StatefulWidget {
  const ViewVisits({super.key});

  @override
  State<ViewVisits> createState() => _ViewVisitsState();
}

class _ViewVisitsState extends State<ViewVisits> {
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
          List<dynamic> eventsData = response['data'];
          List<Business> events = eventsData.map((contactData) {
            return Business(
              id: contactData['id'],
              businessName: contactData['business_name'],
              pitchInterest: contactData['pitch_interest'],
              businessEmailContact:contactData['business_email_contact'],
              businessTelephoneContact: contactData['business_telephone_contact'],
              businessPhysicalAddress:contactData['physical_address'],
              businessContactPersonName:contactData['contact_person_name'],
              businessContactPersonTelephone:contactData['contact_person_telephone'],
              businessContactPersonGender:contactData['contact_person_gender'],
              businessDescription: contactData['notes'],
              businessContactPersonEmail: contactData['contact_person_email'],
            );
          }).toList();
          print("Events: ${events.toString()}");
          return events;
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
    var spacing =size.width*0.14;
    var spacing2 =size.width*0.03;
    //
    var idwidth =size.width*0.18;
    var idheight =size.height*0.06;
    var visitwidth = size.width*0.48;
    var descriptionwidth=size.width*0.3;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(height: size.height*0.01,),
          Padding(
            padding: EdgeInsets.only(left:size.width*0.03, right:size.width*0.03, top:size.width*0.03, bottom:size.width*0.010),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
              },
              decoration: InputDecoration(
                labelText: 'Search by visit name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: AppColors.contentColorPurple), // Change the border color here
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top:size.width*0.01, bottom:size.width*0.03),
            child: Text("Click on the item to see more information", style: GoogleFonts.lato(
              color: Colors.black.withOpacity(0.2)
            ),),
          ),
          Container(
            height: size.height*0.06,
            width: double.maxFinite,
            decoration: const BoxDecoration(
              color: AppColors.contentColorPurple
            ),
            child: Center(
              child: Row(
                
                children: [
                  Container(
                    height: size.height*0.06,
                    width: size.width*0.18,
                    decoration: const BoxDecoration(
                      color: AppColors.contentColorWhite
                    ),
                    child: Center(child: Text("Id", style: GoogleFonts.lato(
        
                    ),))),
                  Container(
                    // margin: EdgeInsets.only(left: size.width*0.01),
                    height: size.height*0.06,
                    width: size.width*0.5,
                    decoration: const BoxDecoration(
                      color: AppColors.contentColorYellow,
                    ),
                    child: Center(child: Text("visit name", style: GoogleFonts.lato(
                    ),))),
                  Container(
                    margin: EdgeInsets.only(left: size.width*0.01),
                    height: size.height*0.06,
                    width: size.width*0.3,
                    decoration: const BoxDecoration(
                      color: AppColors.contentColorPurple,
                    ),
                    child: Center(child: Text("Status", style: GoogleFonts.lato(
                      color:Colors.white
                    ),)))
                ],
              ),
            ),
          ),
      FutureBuilder(
            future: businesses,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("An error occurred"),
                  );
                } else if (snapshot.hasData) {
                  final data = snapshot.data as List<Business>;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        for (var i = 0; i < data.length; i++)
                          buildTableRowWidget(data[i], spacing, spacing2, idwidth, idheight, visitwidth, descriptionwidth),
                      ],
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
  Widget buildTableRowWidget(Business visitData, double size1, double size2, double idwidth, double idheight, double visitwidth, double descriptionwidth) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
        return SingleVisitViewScreen(business: visitData);
      }));
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical:size2),
          child: Row(
             children: [
               Container(
                     height: idheight,
                    width: idwidth,
                    decoration: const BoxDecoration(
                      // color: AppColors.contentColorWhite,
                    ),
                    child: Center(child: Text("${visitData.id}", style: GoogleFonts.lato(
                    ),),),
              ),
              Container(
                     height: idheight,
                    width: visitwidth,
                    decoration: const BoxDecoration(
                      // color: AppColors.contentColorYellow,
                    ),
                    child: Center(child: Text(visitData.businessName, style: GoogleFonts.lato(
              ),))),
              Container(
                    height: idheight,
                    width: descriptionwidth,
                    decoration: const BoxDecoration(
                      // color: AppColors.contentColorPurple,
                    ),
                    child: Center(child: Text(visitData.pitchInterest, style: GoogleFonts.lato(
                      color:Colors.black
                    ),
                    textAlign: TextAlign.center,
                    )))
            ],
          ),
        ),
      ),
    );
  }
}
