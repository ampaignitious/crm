import 'package:valour/Utils/AppColors.dart';
import 'package:valour/Widgets/NotificationWidgets/SingleNotificationDisplayScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override

  // return a list with subject, description, time
  Widget build(BuildContext context) {
  final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.contentColorCyan,
      appBar: AppBar(
        iconTheme: IconThemeData(
        color: AppColors.contentColorPurple,
        size: size.width*0.08,
        ),  // Change the icon color here
        elevation: 0,
        backgroundColor: AppColors.contentColorCyan,
 
        title: Padding(
          padding: EdgeInsets.only(left: size.width*0.14),
          child: Text("Notification page",
           style: GoogleFonts.lato(
            fontSize: size.width*0.05, 
            color: AppColors.contentColorPurple,
            fontWeight: FontWeight.bold
          ),),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(
              color: AppColors.contentColorPurple,
            ),
            SizedBox(height: size.height*0.01,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:EdgeInsets.only(left: size.width*0.03) ,
                  child: Text("Unread Notification", style: GoogleFonts.lato(
                  color: AppColors.contentColorPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: size.width*0.042
                  ),),
                ),
                Padding(
                  padding:EdgeInsets.only(right: size.width*0.04) ,
                  child: Text("Total: 8", style: GoogleFonts.lato(
                    color: AppColors.contentColorPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: size.width*0.032
                  ),),
                )
              ],
            ),
            SizedBox(height: size.height*0.02,),
            Center(
              child: Container(
                height: size.height*0.54,
                width: size.width*0.99,
                decoration: BoxDecoration(
                  color: AppColors.contentColorBlue.withOpacity(0.09),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: AppColors.contentColorPurple.withOpacity(0.4),
                  )
                ),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 8,  // Use filtered data list here
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width*0.01),
                        child: Column(
                          children: [
                            SizedBox(height: size.height*0.01,),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return SingleNotificationDisplayScreen(subject: "Product status", description: "Less coffee products left, you need to alert the sales persons and suppliers", time: "10:35",);
                                }));
                              },
                              child: Card(
                                color: AppColors.contentColorCyan ,
                                child: Padding(
                                  padding:EdgeInsets.all(size.width*0.01),
                                  child: ListTile(
                                  leading: CircleAvatar(
                                    radius: size.width*0.073,
                                    child: const Icon(Icons.notifications_active),
                                  ),
                                  title: Row(
                                    children: [
                                      Text("Subject:", style: GoogleFonts.lato(
                                        // font
                                      ),),
                                      Text(" Product status",style:GoogleFonts.lato(
                                        color: AppColors.contentColorPurple
                                      ))
                                    ],
                                  ),
                                  subtitle: Text("Less coffee products left....", style: GoogleFonts.lato(
                                    color: AppColors.contentColorBlack,
                                  ),),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Time", style: GoogleFonts.lato(
                                        color: AppColors.contentColorRed,
                                        fontWeight: FontWeight.bold,
                                        fontSize: size.width*0.04
                                      ),),
                                      Text("3:45")
                                    ],
                                  ),
                                  ),
                                )),
                            )
                        
                          ],
                        ),
                      );
                      },
                    ),
              ),
            ),
            SizedBox(height:size.height*0.02),
            Center(
              child: Container(
                height: size.height*0.1,
                width: size.width*0.95,
                decoration: BoxDecoration(
                  color: AppColors.contentColorPurple,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: size.width*0.05),
                      child: Row(
                        children: [
                          Text("Machine status: ", style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: size.width*0.047,
                          ),),
                          Text("Low", style: GoogleFonts.lato(
                            color: AppColors.contentColorYellow,
                            fontSize: size.width*0.047,
                            fontWeight: FontWeight.bold
                          ),),
                        ],
                      ),
                    ),
                    
                    // 
                    Container(
                      margin: EdgeInsets.only(right: size.width*0.05),
                      height:size.height*0.09 ,
                      width: size.width*0.16,
                      decoration: BoxDecoration(
                        color: AppColors.contentColorCyan,
                        shape: BoxShape.circle,
                       ),
                       child: Center(
                        child:Text("15")
                       ),
                    ),
                    // 
                  ],
                ),
              ),
            ),
            SizedBox(height:size.height*0.02),
            Center(
              child: Container(
                height: size.height*0.1,
                width: size.width*0.95,
                decoration: BoxDecoration(
                  color: AppColors.contentColorYellow,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text("Send a notification alert")),
              )
            )
          ],
        ),
      ),
    );
  }
}