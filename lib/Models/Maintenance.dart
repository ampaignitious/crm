import 'package:valour/Models/Product.dart';

class Maintenance {
  final int id;
  final String dateOfMaintenance;
  final String comment;
  final String businessName;
  final String visitNotes;
  final List<Product> maintenanceProducts;


  Maintenance({required this.id, required this.dateOfMaintenance, required this.comment, required this.businessName, required this.visitNotes, required this.maintenanceProducts});
} 