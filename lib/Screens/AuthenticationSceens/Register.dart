import 'package:vfu/Controllers/services.dart';
import 'package:vfu/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    // Add more email validation logic if needed
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    // Add more password validation logic if needed
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    // Add more password validation logic if needed
    return null;
  }

  Future<void> _handleRegister() async {
    if (_formKey.currentState?.validate() ?? false) {
      String email = _emailController.text;
      String password = _passwordController.text;
      String name = nameController.text;

      try {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );

        AuthController authController = AuthController();

        final authResponse = await authController.signUp(name, email, password);

        Navigator.pop(context);

        if (authResponse.containsKey('error')) {
          // Handle authentication error
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                "Invalid credentials, check your email and password and try again!"),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: AppColors.contentColorOrange,
            content: Text("Account Created successfully",
                style: TextStyle(color: Colors.white)),
          ));
          Navigator.pushNamed(context, '/login');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Something went wrong. Please try again later."),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: size.height * 0.40,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 253, 245, 229),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset: const Offset(0.8, 1.0),
                    blurRadius: 4.0,
                    spreadRadius: 0.2,
                  ),
                ],
              ),
              child: Center(
                  child: Lottie.asset(
                'assets/json/login2.json', // Path to your Lottie animation JSON file
                width: size.width * 0.7, // Adjust width as needed
                height: size.height * 0.38, // Adjust height as needed
                fit: BoxFit.fill,
              )),
            ),
            // textfield section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Center(
                        child: Text("Create an Account",
                            style: GoogleFonts.lato(
                                fontSize: size.width * 0.06,
                                fontWeight: FontWeight.bold))),
                    SizedBox(height: size.height * 0.016),
                    const Divider(
                      thickness: 0.3,
                      color: AppColors.contentColorOrange,
                    ),
                    SizedBox(height: size.height * 0.02),
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                15)), // Border for the name field
                      ),
                      validator: _validateEmail,
                    ),
                    SizedBox(height: size.height * 0.02),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                15)), // Border for the email field
                      ),
                      validator: _validateEmail,
                    ),
                    SizedBox(
                        height:
                            size.height * 0.02), // Add spacing between fields
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                15)), // Border for the password field
                      ),
                      validator: _validatePassword,
                    ),
                    SizedBox(
                        height:
                            size.height * 0.02), // Add spacing between fields
                    TextFormField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                15)), // Border for the password field
                      ),
                      validator: _validateConfirmPassword,
                    ),
                    SizedBox(height: size.height * 0.02),
                    ElevatedButton(
                      onPressed: _handleRegister,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors
                            .contentColorPurple, // Set button color to purple
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.26,
                          vertical: size.height * 0.032,
                        ),
                        child: const Text('Register'),
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account ? ",
                            style: GoogleFonts.lato()),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: Text("Login",
                              style: GoogleFonts.lato(
                                  color: AppColors.contentColorOrange)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )

            //
          ],
        ),
      ),
    );
  }
}
