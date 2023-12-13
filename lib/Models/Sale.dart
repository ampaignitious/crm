import 'package:valour/Models/Product.dart';

class SaleData {
  final int id;
  final String businessName;
  final String visitNotes;
  final List<Product> saleProducts;


  SaleData({required this.id, required this.businessName, required this.visitNotes, required this.saleProducts});
} 