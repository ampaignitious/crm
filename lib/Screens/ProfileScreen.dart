import 'package:valour/Controllers/services.dart';
import 'package:valour/Models/User.dart';
import 'package:valour/Screens/AuthenticationSceens/LoginScreen.dart';
import 'package:valour/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user;

  Future<void> getUser() async {
    AuthController authController = AuthController();

    final response = await authController.getProfile();
    print("response: $response");

    //assign name and email from response to user object
    user = User(
        name: response['user']['name'] ?? "Full Name",
        email: response['user']['email'] ?? "User Email");

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.contentColorPurple,
          size: size.width * 0.08,
        ),
        backgroundColor: AppColors.contentColorCyan,
        elevation: 0, // Change the icon color here
        title: Padding(
          padding: EdgeInsets.only(left: size.width * 0.04),
          child: Text(
            "Profile Settings",
            style: GoogleFonts.lato(
                color: AppColors.darkRoast, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: size.height * 0.29,
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
                    backgroundImage:
                        const AssetImage("assets/images/userimage.jpg"),
                    radius: size.width * 0.15,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.09),
                  child: Text(
                    "${user?.name}",
                    style: GoogleFonts.lato(
                        fontSize: size.width * 0.055,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.09),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.email,
                        color: AppColors.contentColorPurple,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: size.width * 0.03),
                        child: Text(
                          "${user?.email}",
                          style: GoogleFonts.lato(fontSize: size.width * 0.045),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Padding(
            padding: EdgeInsets.only(left: size.width * 0.06),
            child: Text(
              "Edit profile",
              style: GoogleFonts.lato(fontSize: size.width * 0.052),
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Card(
            child: ListTile(
              leading: Padding(
                padding: EdgeInsets.only(top: size.height * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Username",
                      style: GoogleFonts.lato(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: size.height * 0.004,
                    ),
                    Text(
                      "allamartine",
                      style: GoogleFonts.lato(),
                    )
                  ],
                ),
              ),
              trailing: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return EditProfileDialog(); // Show the EditProfileDialog
                    },
                  );
                },
                child: const Icon(Icons.edit),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: Padding(
                padding: EdgeInsets.only(top: size.height * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Phone number",
                      style: GoogleFonts.lato(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: size.height * 0.004,
                    ),
                    Text(
                      "+256 786740604",
                      style: GoogleFonts.lato(),
                    )
                  ],
                ),
              ),
              trailing: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return EditProfileDialog(); // Show the EditProfileDialog
                    },
                  );
                },
                child: const Icon(Icons.edit),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: Padding(
                padding: EdgeInsets.only(top: size.height * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Password",
                      style: GoogleFonts.lato(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: size.height * 0.004,
                    ),
                    const Text("*******")
                  ],
                ),
              ),
              trailing: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return EditProfileDialog(
                        valueBeingEdited: true,
                      ); // Show the EditProfileDialog
                    },
                  );
                },
                child: const Icon(Icons.edit),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.009,
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const LoginScreen();
              }));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Logout",
                    style: GoogleFonts.lato(fontSize: size.width * 0.06),
                  ),
                  //add an on tap function icon to log out the user
                  IconButton(
                      onPressed: () {
                        AuthController authController = AuthController();
                        authController.signOut();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return const LoginScreen();
                        }));
                      },
                      icon: const Icon(
                        Icons.logout,
                        color: AppColors.contentColorPurple,
                        size: 30,
                      ))
                ],
              ),
            ),
          ),
          const Divider(),
          SizedBox(
            height: size.height * 0.009,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Settings",
                  style: GoogleFonts.lato(fontSize: size.width * 0.06),
                ),
                Icon(
                  Icons.arrow_circle_right_sharp,
                  color: AppColors.contentColorPurple,
                  size: size.width * 0.12,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// widget performing the editing option
// ignore: must_be_immutable
class EditProfileDialog extends StatefulWidget {
  bool? valueBeingEdited;

  EditProfileDialog({this.valueBeingEdited});
  State<EditProfileDialog> createState() =>
      _EditProfileDialogState(this.valueBeingEdited);
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  bool? valueBeingEdited;
  _EditProfileDialogState(this.valueBeingEdited);
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Edit Profile", style: GoogleFonts.lato()),
      content: valueBeingEdited == true
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "New Password",
                  ),
                ),
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                  ),
                )
              ],
            )
          : TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                labelText: "New Value",
              ),
            ),
      actions: <Widget>[
        TextButton(
          child: Text("Cancel", style: GoogleFonts.lato()),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text("Save", style: GoogleFonts.lato()),
          onPressed: () {
            // Handle saving the edited value here
            String newPassword = _passwordController.text;
            String confirmPassword = _confirmPasswordController.text;

            if (valueBeingEdited == true) {
              if (newPassword == confirmPassword) {
                print("passwords match");
                confirmPassword = _passwordController.text;
              }
              Navigator.of(context).pop();
            }
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
