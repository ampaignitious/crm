import 'package:valour/Models/Business.dart';
import 'package:valour/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:valour/Widgets/VisitScreenWidgets/CreateVisitScreen.dart';

class SingleVisitViewScreen extends StatefulWidget {
  final Business? business;
  const SingleVisitViewScreen({super.key, required this.business});

  @override
  SingleVisitViewScreenState createState() => SingleVisitViewScreenState();
}

class SingleVisitViewScreenState extends State<SingleVisitViewScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.contentColorCyan,
        iconTheme: IconThemeData(
          color: AppColors.contentColorPurple,
          size: size.width * 0.08,
        ),
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.only(left: size.width * 0.06),
          child: Text(
            "${widget.business?.businessName ?? ''} Details",
            style: GoogleFonts.lato(
              fontSize: size.width * 0.042,
              color: AppColors.contentColorPurple,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderSection(size),
            _buildBusinessInformationSection(size),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection(Size size) {
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
                          widget.business?.businessTelephoneContact ?? '');
                    },
                  ),
                  const SizedBox(width: 16),
                  // Add an email icon with a button or gesture detector for handling the email action
                  IconButton(
                    icon: const Icon(Icons.email,
                        size: 40, color: AppColors.contentColorPurple),
                    onPressed: () {
                      // Handle the email action here
                      _launchEmail(widget.business?.businessEmailContact ?? '');
                    },
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.add,
                        size: 40, color: AppColors.contentColorPurple),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CreateVisitScreen(
                            businessId: widget.business?.id as int);
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

  Widget _buildBusinessInformationSection(Size size) {
    return Padding(
      padding: EdgeInsets.only(
          left: size.width * 0.06,
          top: size.height * 0.04,
          bottom: size.height * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader("BUSINESS INFORMATION", size),
          SizedBox(height: size.height * 0.02),
          _buildInfoRow("Business Name", widget.business?.businessName ?? '',
              size, Icons.business),
          SizedBox(height: size.height * 0.02),
          _buildSectionHeader("BUSINESS CONTACTS", size),
          SizedBox(height: size.height * 0.02),
          _buildInfoRow(
              "Business Telephone Contact",
              widget.business?.businessTelephoneContact ?? '',
              size,
              Icons.phone),
          SizedBox(height: size.height * 0.01),
          _buildInfoRow("Business Email Contact",
              widget.business?.businessEmailContact ?? '', size, Icons.email),
          SizedBox(height: size.height * 0.02),
          _buildSectionHeader("BUSINESS CONTACT PERSON", size),
          SizedBox(height: size.height * 0.02),
          _buildInfoRow(
              "Contact Person Name",
              widget.business?.businessContactPersonName ?? '',
              size,
              Icons.person),
          SizedBox(height: size.height * 0.01),
          _buildInfoRow(
              "Contact Person Telephone",
              widget.business?.businessContactPersonTelephone ?? '',
              size,
              Icons.phone),
          SizedBox(height: size.height * 0.01),
          _buildInfoRow(
              "Contact Person Email",
              widget.business?.businessContactPersonEmail ?? '',
              size,
              Icons.email),
          SizedBox(height: size.height * 0.01),
          _buildInfoRow(
              "Contact Person Gender",
              widget.business?.businessContactPersonGender ?? '',
              size,
              Icons.person),
          SizedBox(height: size.height * 0.02),
          _buildSectionHeader("BUSINESS REMARKS", size),
          SizedBox(height: size.height * 0.02),
          _buildInfoRow("Notes on the first Visit",
              widget.business?.businessDescription ?? '', size, Icons.notes),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, Size size) {
    return Text(
      title,
      style: GoogleFonts.lato(
        fontSize: size.width * 0.05,
        color: const Color.fromARGB(255, 30, 14, 34),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildInfoRow(
      String label, String value, Size size, IconData iconData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.lato(
            fontSize: size.width * 0.04,
            color: Colors.black.withOpacity(0.6),
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            Icon(iconData), // Use the provided iconData parameter
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                value,
                style: GoogleFonts.lato(
                  fontSize: size.width * 0.04,
                  color: Colors.black.withOpacity(0.6),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _launchEmail(String email) async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

// ···
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
