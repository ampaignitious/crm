import 'package:valour/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valour/Models/Demo.dart';

class DemoDetails extends StatefulWidget {
  final DemoData? demo;
  const DemoDetails({super.key, required this.demo});

  @override
  DemoDetailsState createState() => DemoDetailsState();
}

class DemoDetailsState extends State<DemoDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.contentColorPurple,
          size: size.width * 0.08,
        ), // Change the icon color here
        elevation: 0,
        backgroundColor: AppColors.contentColorCyan,

        title: Padding(
          padding: EdgeInsets.only(left: size.width * 0.03),
          child: Text(
            "Demo Details",
            style: GoogleFonts.lato(
                fontSize: size.width * 0.038,
                color: AppColors.menuBackground,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildBusinessInformationSection(size),
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
          _buildInfoRow("Business Name", widget.demo?.businessName ?? '', size,
              Icons.business),
          SizedBox(height: size.height * 0.02),
          _buildSectionHeader("ABOUT DEMO", size),
          SizedBox(height: size.height * 0.02),
          _buildInfoRow("Machine Demo Date", widget.demo?.demoDate ?? '', size,
              Icons.calendar_today_outlined),
          SizedBox(height: size.height * 0.02),
          _buildSectionHeader("DEMO NOTES", size),
          SizedBox(height: size.height * 0.02),
          _buildInfoRow("Demo Notes", widget.demo?.demoNotes ?? '', size,
              Icons.comment_outlined),
          SizedBox(height: size.height * 0.02),
          _buildSectionHeader("VISIT REMARKS", size),
          SizedBox(height: size.height * 0.02),
          _buildInfoRow("Visit Notes", widget.demo?.visitNotes ?? '', size,
              Icons.notes_outlined),
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
}
