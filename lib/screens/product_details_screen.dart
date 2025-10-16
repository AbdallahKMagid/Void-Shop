import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/my_colors.dart';

import '../providers/product_provider.dart';

class ProductDetails extends StatelessWidget {
  final Map product;

  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().clearSelectedImage();
    });
    final List images = product["images"] ?? [];

    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20), // Adjust radius for desired curve
          ),
        ),
        title: Text("Product Details"),
        centerTitle: true,
        backgroundColor: MyColors.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<ProductProvider>(
              builder: (context, provider, child) {
                final selectedImage =
                    provider.selectedImage ?? product["thumbnail"];

                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              color: Colors.black,
                              child: Center(
                                child: InteractiveViewer(
                                  child: Image.network(
                                    selectedImage,
                                    fit: BoxFit.contain,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(
                                              Icons.broken_image,
                                              color: Colors.white,
                                              size: 100,
                                            ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          selectedImage,
                          height: 250,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                height: 250,
                                color: Colors.grey[200],
                                child: const Icon(Icons.broken_image, size: 60),
                              ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    if (images.isNotEmpty)
                      SizedBox(
                        height: 80,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: images.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            final img = images[index];
                            return GestureDetector(
                              onTap: () => provider.setImage(img),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  img,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                        width: 80,
                                        height: 80,
                                        color: Colors.grey[300],
                                        child: const Icon(Icons.broken_image),
                                      ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                );
              },
            ),

            const SizedBox(height: 16),

            Text(
              "${product["title"]}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(
              "${product["price"]}\$",
              style: TextStyle(
                fontSize: 18,
                color: MyColors.secondaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              product["description"],
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: MyColors.primaryColor,
          boxShadow: [
            BoxShadow(
              color: MyColors.secondaryColor,
              blurRadius: 6,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: ElevatedButton.icon(
          onPressed: () async {
            Fluttertoast.showToast(
              msg: "Item added to cart",
              backgroundColor: Colors.green,
            ).then((_) async {
              final provider = context.read<ProductProvider>();
              await provider.addCart(
                item: {
                  "id": product["id"],
                  "title": product["title"],
                  "price": product["price"],
                  "quantity": 1,
                },
              );
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.secondaryColor,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          icon: Icon(Icons.shopping_cart, color: MyColors.mainColor),
          label: Text(
            "Add to Cart",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: MyColors.mainColor,
            ),
          ),
        ),
      ),
    );
  }
}
