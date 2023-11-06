import 'package:aiDvantage/Controllers/services.dart';
import 'package:aiDvantage/Screens/DefaultScreen.dart';
import 'package:aiDvantage/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
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

  Future<void> _handleLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Form is valid, perform login operation here
      // For example, you can send a request to your API for authentication
      String email = _emailController.text;
      String password = _passwordController.text;

      print('Email: $email---Password: $password');

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
        final authResponse = await authController.signIn(email, password);

        Navigator.pop(context);

        if (authResponse.containsKey('error')) {
          // Handle authentication error
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                "Invalid credentials, check your email and password and try again!"),
          ));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return DefaultScreen();
          }));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Something went wrong. Please try again later."),
        ));
      }
    }
  }

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
              height: size.height*0.40,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 253, 245, 229),
                borderRadius: const BorderRadius.only(
                  bottomLeft:Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: Offset(0.8, 1.0),
                        blurRadius: 4.0,
                        spreadRadius: 0.2,
                      ),
                    ],
              ),
              child: Center(
                    child: Lottie.asset(
                  'assets/json/login2.json', // Path to your Lottie animation JSON file
                  width: size.width*0.7, // Adjust width as needed
                  height: size.height*0.38, // Adjust height as needed
                  fit: BoxFit.fill,
                    )
              ),
            ),
        // textfield section
        Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
        children: <Widget>[
          Center(child: Text("Login to continue", style:GoogleFonts.lato(
                    fontSize: size.width*0.06,
                    fontWeight: FontWeight.bold
          ))),
          SizedBox(height: size.height*0.016),
          const Divider(
            thickness: 0.3,
            color: AppColors.contentColorPurple,
          ),
          SizedBox(height: size.height*0.02),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15)
              ),  // Border for the email field
            ),
            validator: _validateEmail,
          ),
          SizedBox(height: size.height*0.035), // Add spacing between fields
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15)
              ),  // Border for the password field
            ),
            validator: _validatePassword,
          ),
          SizedBox(height: size.height*0.015),
          Text("Forgot password ?", style: GoogleFonts.lato(
      
          )),
          SizedBox(height: size.height*0.055),
          ElevatedButton(
            onPressed: _handleLogin,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width*0.26,
                vertical: size.height*0.032,
              ),
              child: Text('Login'),
            ),
              style: ElevatedButton.styleFrom(
              primary: AppColors.contentColorPurple,  // Set button color to purple
            ),
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