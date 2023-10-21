import 'package:crm/Screens/AuthenticationSceens/LoginScreen.dart';
import 'package:crm/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
        iconTheme: IconThemeData(
        color: AppColors.contentColorPurple,
        size: size.width*0.08,
        ),  
        backgroundColor: AppColors.contentColorCyan,
        elevation: 0,// Change the icon color here
        title: Padding(
          padding: EdgeInsets.only(left: size.width*0.04),
          child: Text("User profile screen", style: GoogleFonts.lato(
            color: AppColors.darkRoast,
            fontWeight: FontWeight.bold
          ),),
        ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
          height: size.height*0.29,
          width: double.maxFinite,
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
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/userimage.jpg"),
                  radius: size.width*0.15,
                ),
              ),
              SizedBox(height: size.height*0.03,),
              Padding(
                padding: EdgeInsets.only(left: size.width*0.09),
                child: Text("Allan martin", style: GoogleFonts.lato(
                  fontSize: size.width*0.055,
                  fontWeight: FontWeight.bold
                ),),
              ),
              SizedBox(height: size.height*0.01,),
             Padding(
               padding: EdgeInsets.only(left: size.width*0.09),
               child: Row(children: [
                Icon(Icons.email,
                color: AppColors.contentColorPurple,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width*0.03),
                  child: Text("allamartin@gmail.com"),
                )
               ],),
             )
            ],
          ),
          ),
          SizedBox(height: size.height*0.02,),
          Padding(
            padding: EdgeInsets.only(left: size.width*0.06),
            child: Text("Edit profile", style: GoogleFonts.lato(
              fontSize:size.width*0.052
            ),),
          ),
          SizedBox(height: size.height*0.01,),
          Card(
            child: ListTile(
              leading: Padding(
                padding: EdgeInsets.only(top: size.height*0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Username", style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: size.height*0.004,),
                    Text("allamartine", style: GoogleFonts.lato(),)
                  ],
                ),
              ),
              trailing: Icon(Icons.edit),
            ),
          ),
          Card(
            child: ListTile(
              leading: Padding(
                padding: EdgeInsets.only(top: size.height*0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Phone number", style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: size.height*0.004,),
                    Text("+256 786740604", style: GoogleFonts.lato(),)
                  ],
                ),
              ),
              trailing: Icon(Icons.edit),
            ),
          ),
          Card(
            child: ListTile(
              leading: Padding(
                padding: EdgeInsets.only(top: size.height*0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Password", style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: size.height*0.004,),
                    Text("*******")
                  ],
                ),
              ),
              trailing: Icon(Icons.edit),
            ),
          ),
          SizedBox(height: size.height*0.009,),
          InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                return LoginScreen();
              }));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width*0.06),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Logout", style: GoogleFonts.lato(
                    fontSize: size.width*0.06
                  ),),
                  Icon(Icons.arrow_circle_right_sharp,
                  color: AppColors.contentColorPurple,
                  size: size.width*0.12,
                  )
                ],
              ),
            ),
          ),
          Divider(),
          SizedBox(height: size.height*0.009,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width*0.06),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Settings", style: GoogleFonts.lato(
                  fontSize: size.width*0.06
                ),),
                Icon(Icons.arrow_circle_right_sharp,
                color: AppColors.contentColorPurple,
                size: size.width*0.12,
                )
              ],
            ),
          )
          ],
        ),
    );
  }
}