class Business {
  final int id;
  final String businessName;
  final String businessTelephoneContact;
  final String businessEmailContact;
  final String businessPhysicalAddress;
  final String businessContactPersonName;
  final String businessContactPersonTelephone;
  final String businessContactPersonEmail;
  final String businessContactPersonGender;
  final String pitchInterest;
  final String businessDescription;

  Business({required this.id, required this.businessName, required this.pitchInterest, required this.businessDescription, required this.businessContactPersonEmail, required this.businessContactPersonGender, required this.businessContactPersonName, required this.businessContactPersonTelephone, required this.businessEmailContact, required this.businessPhysicalAddress, required this.businessTelephoneContact});
}