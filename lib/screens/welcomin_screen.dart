import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/my_colors.dart';
import 'package:shoppy/screens/cart_screen.dart';
import 'package:shoppy/screens/search_screen.dart';

import '../providers/product_provider.dart';
import 'all_product_screen.dart';
import 'categories_screen.dart';

class WelcomingScreen extends StatelessWidget {
  WelcomingScreen({super.key});

  final List<Widget> pages = [
    AllProductsScreen(),
    CategoriesScreen(),
    CartScreen(),
    SearchScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, providerObj, child) {
        return Scaffold(
          bottomNavigationBar: SafeArea(
            child: BottomNavigationBar(
              currentIndex: providerObj.currentIndex,
              onTap: (index) {
                providerObj.setCurrentIndex(index);
              },
              selectedItemColor: MyColors.secondaryColor,
              unselectedItemColor: MyColors.mainColor,
              backgroundColor: MyColors.primaryColor,

              type: BottomNavigationBarType.fixed,
              elevation: 10,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.category_outlined),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search_outlined),
                  label: 'Search',
                ),
              ],
            ),
          ),
          body: IndexedStack(index: providerObj.currentIndex, children: pages),
        );
      },
    );
  }
}
