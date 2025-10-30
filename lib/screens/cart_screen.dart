import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../my_colors.dart';
import '../providers/product_provider.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "My Cart",
            style: TextStyle(
              color: MyColors.mainColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: MyColors.primaryColor,
      ),
      body: Consumer<ProductProvider>(
        builder: (context, providerObj, child) {
          final cartItems = providerObj.cart;

          if (cartItems.isEmpty) {
            return const Center(
              child: Text(
                "Cart is empty",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: cartItems.length + 1,
              itemBuilder: (context, index) {
                if (index < cartItems.length) {
                  final item = cartItems[index];
                  return CartItemCard(product: item, index: index);
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(
                      child: Text(
                        "Total: ${providerObj.getTotalPrice().toStringAsFixed(2)}\$",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: MyColors.secondaryColor,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
