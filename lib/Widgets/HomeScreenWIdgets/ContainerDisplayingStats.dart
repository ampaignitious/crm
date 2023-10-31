import 'package:aiDvantage/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';

class ContainerDisplayingStats extends StatefulWidget {
  const ContainerDisplayingStats({super.key});

  @override
  State<ContainerDisplayingStats> createState() => _ContainerDisplayingStatsState();
}

class _ContainerDisplayingStatsState extends State<ContainerDisplayingStats> {
  // 
  Stream<DateTime> createTimeStream() {
  return Stream.periodic(Duration(seconds: 1), (i) {
    return DateTime.now();
  });
}
  // 
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String formattedTime = DateFormat('HH:mm:ss').format(DateTime.now());
    final size = MediaQuery.of(context).size;
    return Center(
        child: Container(
          height: size.height*0.29,
          width: size.width*0.95,
          decoration: BoxDecoration(
            color: AppColors.contentColorCyan,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          offset: Offset(0.8, 1.0),
                          blurRadius: 4.0,
                          spreadRadius: 0.2,
                        ),
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          offset: Offset(0.8, 1.0),
                          blurRadius: 4.0,
                          spreadRadius: 0.2,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: size.width*0.03,
                    ),
                    child: Row(
                      children: [
                        Lottie.asset(
                        'assets/json/date.json', // Path to your Lottie animation JSON file
                        width: size.width*0.08, // Adjust width as needed
                        height: size.height*0.04,  
                        fit: BoxFit.fill,
                          ),
                        Text(formattedDate,
                        style: GoogleFonts.lato(
                          fontSize: size.width*0.04
                        )
                        ),
                      ],
                    ),
                  ),
                               // 
              Row(
                children: [
                  Lottie.asset(
                  'assets/json/time.json', // Path to your Lottie animation JSON file
                  width: size.width*0.14, // Adjust width as needed
                  height: size.height*0.07,  
                  fit: BoxFit.fill,
                    ),
                StreamBuilder<DateTime>(
                stream: createTimeStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    String formattedTime =
                        DateFormat('HH:mm:ss').format(snapshot.data ?? DateTime.now());
                    return Padding(
                      padding: EdgeInsets.only(right: size.width*0.03),
                      child: Text(
                        ' $formattedTime',
                        style: GoogleFonts.lato(fontSize: size.width*0.04),
                      ),
                    );
                  } else {
                    return Text(formattedTime);
                  }
                },
              ),
                ],
              )
                ],
              ),
              Divider(
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width*0.03),
                child: Text("Monthly target", style: GoogleFonts.lato(
              color: AppColors.contentColorPurple
                ),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: size.width*0.03),
                    height: size.height*0.14,
                    width: size.width*0.2,
                    decoration: BoxDecoration(
                      image:DecorationImage(
                        image: AssetImage("assets/images/piechart.png"),
                        // fit: BoxFit.fill
                        ) ,

                    ),
                  ),
                  // 
                  Container(
                    height: size.height*0.14,
                    width: size.width*0.008,
                    decoration: BoxDecoration(
                      color: Colors.black
                    ),
                  ),
                Padding(
                  padding:EdgeInsets.only(right: size.width*0.06),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: size.height*0.016,),
                        child: Text("Upcoming visits: 20"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: size.height*0.016),
                        child: Text("Mainteance: 15"),
                      ),
                      Text("Total sales: 15", style: GoogleFonts.lato(
                        fontWeight:FontWeight.bold
                      ),)
                    ],
                  ),
                )
                // 
                ],
              )
            ],
          ),
        ),
      );
  }
}