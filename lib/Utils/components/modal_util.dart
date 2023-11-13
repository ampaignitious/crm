import 'package:flutter/material.dart';
import 'package:valour/Utils/AppColors.dart';
import 'package:valour/Models/Product.dart';

class ModalUtils {
  static void showSimpleModalDialog(
      BuildContext context, List<Product> productList,
      {bool isOrder = true}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: StatefulBuilder(
            builder: (BuildContext context, setState) {
              return Container(
                constraints: const BoxConstraints(maxHeight: 350),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Product List',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: productList.length,
                          itemBuilder: (context, index) {
                            Product product = productList[index];
                            return ListTile(
                              title: Text(product.product_name),
                              textColor: isOrder
                                  ? (product.isSelected
                                      ? AppColors.contentColorPurple
                                      : Colors.grey)
                                  : (product.isOrdered
                                      ? AppColors.contentColorPurple
                                      : Colors.grey),
                              subtitle: Text(
                                  'Price: \$${product.product_price.toString()}'),
                              trailing: isOrder
                                  ? Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.remove),
                                          onPressed: () {
                                            _handleRemoveButtonPressed(
                                                product, setState);
                                          },
                                        ),
                                        Text(product.product_quantity
                                            .toString()),
                                        IconButton(
                                          icon: const Icon(Icons.add),
                                          onPressed: () {
                                            _handleAddButtonPressed(
                                                product, setState);
                                          },
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        product.isOrdered
                                            ? IconButton(
                                                icon: const Icon(Icons.remove),
                                                onPressed: () {
                                                  _handleRemoveOrderButtonPressed(
                                                      product, setState);
                                                },
                                              )
                                            : IconButton(
                                                icon: const Icon(Icons.add),
                                                onPressed: () {
                                                  _handleAddOrderButtonPressed(
                                                      product, setState);
                                                },
                                              ),
                                      ],
                                    ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pop(); // Close the dialog when "OK" button is pressed
                          },
                          child: const Text('OK',
                              style: TextStyle(
                                  color: AppColors.contentColorPurple)),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  static void _handleRemoveButtonPressed(Product product, Function setState) {
    if (product.product_quantity > 0) {
      product.product_quantity--;
      product.isSelected = false;
      setState(() {});
    }
  }

  static void _handleAddButtonPressed(Product product, Function setState) {
    product.product_quantity++;
    product.isSelected = true;
    setState(() {});
  }

  static void _handleRemoveOrderButtonPressed(
      Product product, Function setState) {
    if (product.product_quantity > 0) {
      product.isOrdered = false;
      setState(() {});
    }
  }

  static void _handleAddOrderButtonPressed(Product product, Function setState) {
    product.isOrdered = true;
    setState(() {});
  }
}
