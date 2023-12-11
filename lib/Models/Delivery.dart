import 'package:valour/Models/Product.dart';

class DeliveryData {
  final int id;
  final String businessName;
  final String visitNotes;
  final List<Product> deliveryProducts;


  DeliveryData({required this.id, required this.businessName, required this.visitNotes, required this.deliveryProducts});
} 