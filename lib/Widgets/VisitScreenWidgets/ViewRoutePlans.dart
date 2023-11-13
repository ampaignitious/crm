import 'package:valour/Controllers/services.dart';
import 'package:valour/Utils/AppColors.dart';
import 'package:valour/Widgets/VisitScreenWidgets/SingleRouteViewScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valour/Models/Route.dart';

class ViewRoutePlans extends StatefulWidget {
  const ViewRoutePlans({super.key});

  @override
  State<ViewRoutePlans> createState() => _ViewRoutePlansState();
}

class _ViewRoutePlansState extends State<ViewRoutePlans> {
  TextEditingController searchController = TextEditingController();
  late Future<List<SalesRoute>> routes;

  @override
  void initState() {
    super.initState();
    routes = getRoutePlans();
  }

  Future<List<SalesRoute>> getRoutePlans() async {
    AuthController authController = AuthController();
    try {
      final response = await authController.getRoutePlans();
      if (response.containsKey("error")) {
        throw Exception("The return is an error");
      } else {
        if (response['data'] != null) {
          List<dynamic> routesData = response['data'];
          List<SalesRoute> salesRoutes = routesData.map((routeData) {
            return SalesRoute(
              id: routeData['id'],
              routeName: routeData['route_name'],
              description: routeData['route_description'],
              startLocation: routeData['start_location'],
              endLocation: routeData['end_location'],
            );
          }).toList();
          return salesRoutes;
        } else {
          // Handle the case where the 'contacts' field in the API response is null
          throw Exception("No data found");
        }
      }
    } catch (error) {
      print("error: $error");
      // Handle the case where the 'contacts' field in the API response is null
      throw Exception("Un expected error occurreddffd");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var spacing = size.width * 0.14;
    var spacing2 = size.width * 0.03;
    //
    var idwidth = size.width * 0.18;
    var idheight = size.height * 0.06;
    var visitwidth = size.width * 0.48;
    var descriptionwidth = size.width * 0.3;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                labelText: 'Search by route name',
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
                        "route name",
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
                        "Description",
                        style: GoogleFonts.lato(color: Colors.white),
                      )))
                ],
              ),
            ),
          ),
          FutureBuilder(
            future: routes,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  //print the error
                  print("snapshot error: ${snapshot.error.toString()}");
                  return const Center(
                    child: Text("An error occurred"),
                  );
                } else if (snapshot.hasData) {
                  final data = snapshot.data as List<SalesRoute>;
                  return SizedBox(
                    height: size.height * 0.62,
                    width: double.maxFinite,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        final SalesRoute businessData = data[index];
                        return buildTableRowWidget(
                            businessData,
                            spacing,
                            spacing2,
                            idwidth,
                            idheight,
                            visitwidth,
                            descriptionwidth);
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
      SalesRoute visitData,
      double size1,
      double size2,
      double idwidth,
      double idheight,
      double visitwidth,
      double descriptionwidth) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SingleRouteViewScreen(
              routeName: visitData.routeName,
              routeDescription: visitData.description,
              routeStartLocation: visitData.startLocation,
              routeEndLocation: visitData.endLocation);
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
                decoration: const BoxDecoration(),
                child: Center(
                  child: Text(
                    "${visitData.id}",
                    style: GoogleFonts.lato(),
                  ),
                ),
              ),
              Container(
                  height: idheight,
                  width: visitwidth,
                  decoration: const BoxDecoration(),
                  child: Center(
                      child: Text(
                    visitData.routeName,
                    style: GoogleFonts.lato(),
                  ))),
              Container(
                  height: idheight,
                  width: descriptionwidth,
                  decoration: const BoxDecoration(),
                  child: Center(
                      child: Text(
                    visitData.description,
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
