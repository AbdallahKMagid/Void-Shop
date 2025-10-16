import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/my_colors.dart';
import 'package:shoppy/providers/product_provider.dart';
import 'package:shoppy/widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});

  static Future<List>? categoriesFuture;

  final Map<String, dynamic> categoryPics = {
    "beauty": "assets/categoryPics/beauty.jpg",
    "fragrances": "assets/categoryPics/fragrances.jpg",
    "furniture": "assets/categoryPics/furniture.jpg",
    "groceries": "assets/categoryPics/groceries.jpg",
    "home-decoration": "assets/categoryPics/home_decoration.jpg",
    "kitchen-accessories": "assets/categoryPics/kitchen_accessories.jpg",
    "laptops": "assets/categoryPics/laptops.jpg",
    "mens-shirts": "assets/categoryPics/mens_shirts.jpg",
    "mens-shoes": "assets/categoryPics/mens_shoes.jpg",
    "mens-watches": "assets/categoryPics/mens_watches.jpg",
    "mobile-accessories": "assets/categoryPics/mobile_accessories.jpg",
    "motorcycle": "assets/categoryPics/motorcycle.jpg",
    "skin-care": "assets/categoryPics/skin_care.jpg",
    "smartphones": "assets/categoryPics/smartphones.jpg",
    "sports-accessories": "assets/categoryPics/sports_accessories.jpg",
    "sunglasses": "assets/categoryPics/sunglasses.jpg",
    "tablets": "assets/categoryPics/tablets.jpg",
    "tops": "assets/categoryPics/tops.jpg",
    "vehicle": "assets/categoryPics/vehicle.jpg",
    "womens-bags": "assets/categoryPics/womens_bags.jpg",
    "womens-dresses": "assets/categoryPics/womens_dresses.jpg",
    "womens-jewellery": "assets/categoryPics/womens_jewellery.jpg",
    "womens-shoes": "assets/categoryPics/womens_shoes.jpg",
    "womens-watches": "assets/categoryPics/womens_watches.jpg",
  };

  @override
  Widget build(BuildContext context) {
    categoriesFuture ??= context.read<ProductProvider>().fetchCategories();

    return Scaffold(
      backgroundColor: MyColors.mainColor,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        backgroundColor: MyColors.primaryColor,
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Categories",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: FutureBuilder<List>(
        future: categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          final categories = snapshot.data ?? [];

          if (categories.isEmpty) {
            return Center(
              child: Text(
                "No categories found",
                style: TextStyle(color: MyColors.primaryColor, fontSize: 18),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.8,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index] ?? "unknown";
                final categoryName = category["slug"] ?? "unknown";
                final imagePath =
                    categoryPics[categoryName] ??
                    "assets/categoryPics/default.jpg";
                return CategoryItem(category: category, imgPath: imagePath);
              },
            ),
          );
        },
      ),
    );
  }
}
