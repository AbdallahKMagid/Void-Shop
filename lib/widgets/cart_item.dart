import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../my_colors.dart';
import '../providers/product_provider.dart';

class CartItemCard extends StatelessWidget {
  final Map product;
  final int index;

  const CartItemCard({super.key, required this.product, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MyColors.mainColor,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product["title"],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${product["price"]}\$",
                    style: TextStyle(
                      color: MyColors.secondaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    context.read<ProductProvider>().decreaseQuantity(product);
                  },
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text(
                  "${product["quantity"]}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context.read<ProductProvider>().increaseQuantity(product);
                  },
                  icon: const Icon(Icons.add_circle_outline),
                ),
                IconButton(
                  onPressed: () {
                    Fluttertoast.showToast(
                      msg: "Item Deleted",
                      backgroundColor: Colors.green,
                    ).then((_) {
                      context.read<ProductProvider>().removeItem(index);
                    });
                  },
                  icon: const Icon(Icons.delete_forever_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
