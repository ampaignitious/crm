class AppointmentData {
  int id;
  final String meetingDate;
  final String meetingStartTime;
  final String meetingEndTime;
  final String meetingNotes;
  final String businessName;
  final String visitNotes;

  AppointmentData({
    required this.id,
    required this.meetingDate,
    required this.meetingStartTime,
    required this.meetingEndTime,
    required this.meetingNotes,
    required this.businessName,
    required this.visitNotes,
  });
}
