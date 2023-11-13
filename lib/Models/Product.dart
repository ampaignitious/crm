class Product {
  int id;
  final String product_name;
  int product_price;
  int product_quantity;
  bool isSelected;
  bool isOrdered; // isSelected property should not be nullable

  Product({
    required this.id,
    required this.product_name,
    required this.product_price,
    required this.product_quantity,
    this.isSelected = false, // Provide a default value for isSelected
    this.isOrdered = false, // Provide a default value for isOrdered
  });
}
