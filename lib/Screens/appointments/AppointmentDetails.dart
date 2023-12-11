import 'package:valour/Models/Appointment.dart';
import 'package:valour/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppointmentDetails extends StatefulWidget {
  final AppointmentData? appointment;
  const AppointmentDetails({super.key, required this.appointment});

  @override
  AppointmentDetailsState createState() => AppointmentDetailsState();
}

class AppointmentDetailsState extends State<AppointmentDetails> {
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
            "Meeting Details",
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
          _buildInfoRow("Business Name", widget.appointment?.businessName ?? '', size,
              Icons.business),
          SizedBox(height: size.height * 0.02),
          _buildSectionHeader("ABOUT MEETING", size),
          SizedBox(height: size.height * 0.02),
          _buildInfoRow("Meeting Date", widget.appointment?.meetingDate ?? '', size,
              Icons.calendar_today_outlined),
                        SizedBox(height: size.height * 0.01),
          _buildInfoRow("Meeting Start Time", widget.appointment?.meetingStartTime ?? '', size,
              Icons.calendar_today_outlined),
                        SizedBox(height: size.height * 0.01),
          _buildInfoRow("Meeting End Time", widget.appointment?.meetingEndTime ?? '', size,
              Icons.calendar_today_outlined),
          SizedBox(height: size.height * 0.02),
          _buildSectionHeader("MEETING NOTES", size),
          SizedBox(height: size.height * 0.02),
          _buildInfoRow("Meeting Notes", widget.appointment?.meetingNotes ?? '', size,
              Icons.comment_outlined),
          SizedBox(height: size.height * 0.02),
          _buildSectionHeader("VISIT REMARKS", size),
          SizedBox(height: size.height * 0.02),
          _buildInfoRow("Visit Notes", widget.appointment?.visitNotes ?? '', size,
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
