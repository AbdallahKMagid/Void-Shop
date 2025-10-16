import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/my_colors.dart';
import 'package:shoppy/providers/product_provider.dart';

import '../providers/auth_provider.dart';
import '../widgets/product_widget.dart';
import 'login_screen.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});

  static Future<void>? productsFuture;

  @override
  Widget build(BuildContext context) {
    productsFuture ??= context.read<ProductProvider>().fetchProducts();

    return Scaffold(
      backgroundColor: MyColors.mainColor,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        elevation: 0,
        backgroundColor: MyColors.primaryColor,
        title: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            "Home",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: MyColors.mainColor,
            ),
          ),
        ),
        actions: [
          Consumer<ProductProvider>(
            builder: (context, provider, child) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    dropdownColor: MyColors.mainColor,
                    value: provider.currentSortOption,
                    alignment: Alignment.centerRight,
                    items: [
                      DropdownMenuItem(
                        value: 'none',
                        child: Text(
                          'No Sort',
                          style: TextStyle(color: MyColors.mainColor),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'title',
                        child: Text('Sort by Title (A-Z)'),
                      ),
                      DropdownMenuItem(
                        value: 'price',
                        child: Text('Sort by Price'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        provider.sortProducts(value);
                      }
                    },
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 4),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              child: Icon(
                Icons.logout_rounded,
                size: 28,
                color: MyColors.mainColor,
              ),
              onTap: () async {
                await context.read<AuthProvider>().signOut();
                Fluttertoast.showToast(
                  msg: "LoggedOut Successfully",
                  backgroundColor: Colors.green,
                ).then((_) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                });
              },
            ),
          ),
        ],
      ),

      body: FutureBuilder(
        future: productsFuture,
        builder: (context, snapshot) {
          final products = context
              .watch<ProductProvider>()
              .productsModel
              ?.products;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (products == null || products.isEmpty) {
            return Center(
              child: Text(
                "No products found",
                style: TextStyle(color: MyColors.primaryColor),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductWidget(product: product);
              },
              itemCount: products.length,
            ),
          );
        },
      ),
    );
  }
}
