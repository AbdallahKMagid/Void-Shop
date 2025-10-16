import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/my_colors.dart';
import 'package:shoppy/providers/product_provider.dart';

import '../widgets/product_widget.dart';

class CategoryItemsScreen extends StatelessWidget {
  final String category;

  const CategoryItemsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ProductProvider>();

    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20), // Adjust radius for desired curve
          ),
        ),
        title: Text("$category Category"),
        centerTitle: true,
        backgroundColor: MyColors.primaryColor,
      ),
      body: FutureBuilder(
        future: provider.fetchProductsByCategories(category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("Error loading products: ${snapshot.error}"),
            );
          }

          final products = provider.categoryProductsModel?.products ?? [];

          if (products.isEmpty) {
            return const Center(child: Text("No products found"));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductWidget(product: product);
            },
          );
        },
      ),
    );
  }
}
