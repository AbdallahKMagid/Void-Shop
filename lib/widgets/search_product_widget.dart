import 'package:flutter/material.dart';

import '../my_colors.dart';
import '../screens/product_details_screen.dart';

class SearchProductWidget extends StatelessWidget {
  final Map product;

  const SearchProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ProductDetails(product: product)),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: MyColors.mainColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: MyColors.primaryColor,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🖼️ Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                product["thumbnail"] ?? "https://via.placeholder.com/120",
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 80,
                  height: 80,
                  color: MyColors.mainColor,
                  child: Icon(Icons.broken_image, color: MyColors.mainColor),
                ),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product["title"] ?? "No title",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    product["brand"] != null
                        ? product["brand"]
                        : product["category"] ?? "",
                    style: TextStyle(
                      fontSize: 13,
                      color: MyColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "${product["price"] ?? 0}\$",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: MyColors.secondaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
