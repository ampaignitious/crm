import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:valour/Models/Contact.dart';
import 'package:valour/Utils/AppColors.dart';
import 'package:valour/Widgets/VisitScreenWidgets/CreateVisitScreen.dart';

class ContactCard extends StatelessWidget {
  final Contact contact;

  const ContactCard({required this.contact, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.contentColorCyan,
          title: const Text('Contact Details'),
        ),
        body: Column(children: [
          _buildHeaderSection(MediaQuery.of(context).size, context),
          _buildSectionHeader('Contact Activity Logs'),
          _buildContactActivitySection(MediaQuery.of(context).size),
        ]));
  }

  Widget _buildHeaderSection(Size size, BuildContext context) {
    return Container(
      height: size.height * 0.15,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: AppColors.contentColorCyan,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: const Offset(0.8, 1.0),
            blurRadius: 4.0,
            spreadRadius: 0.2,
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Add a call icon with a button or gesture detector for handling the call action
                  IconButton(
                    icon: const Icon(Icons.call,
                        size: 40, color: AppColors.contentColorPurple),
                    onPressed: () {
                      // Handle the call action here
                      FlutterPhoneDirectCaller.callNumber(
                          contact.contactNumber);
                    },
                  ),
                  const SizedBox(width: 16),
                  // Add an email icon with a button or gesture detector for handling the email action
                  IconButton(
                    icon: const Icon(Icons.email,
                        size: 40, color: AppColors.contentColorPurple),
                    onPressed: () {
                      // Handle the email action here
                      _launchEmail(contact.email);
                    },
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.note_add,
                        size: 40, color: AppColors.contentColorPurple),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CreateVisitScreen(businessId: contact.id);
                      }));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

Widget _buildContactActivitySection(Size size) {
  return Container(
    margin: const EdgeInsets.all(8.0),
    height: size.height * 0.15,
    width: double.maxFinite,
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.grey, // You can change the color of the border
        width: 1.0, // You can adjust the width of the border
      ),
      borderRadius: BorderRadius.circular(8.0), // You can adjust the border radius
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Contact Activity',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        // Box with round corners that has activity title, time stamp, and description
        // You can add your activity log items here
      ],
    ),
  );
}

  void _launchEmail(String email) async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<String, String>{
        'subject': 'Business Inquiry',
        'body': 'Hello, I would like to inquire about your business',
      }),
    );

    launchUrl(emailLaunchUri);
  }
}
