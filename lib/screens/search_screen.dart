import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/my_colors.dart';
import 'package:shoppy/widgets/search_product_widget.dart';

import '../providers/product_provider.dart';
import '../widgets/text_form_field.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, providerObj, child) {
        return Scaffold(
          backgroundColor: MyColors.mainColor,
          body: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 40, 16, 3),
                decoration: BoxDecoration(
                  color: MyColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: MyColors.mainColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextFormFieldWidget(
                    icon: Icons.search_outlined,
                    label: "Search for products...",
                    isPassWord: false,
                    controller: searchController,
                    onChanged: (value) {
                      if (value.trim().isNotEmpty) {
                        providerObj.searchProducts(value.trim());
                      } else {
                        providerObj.clearSearchResults();
                      }
                    },
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Expanded(
                child: SafeArea(
                  top: false,
                  child: providerObj.isSearching
                      ? const Center(child: CircularProgressIndicator())
                      : providerObj.searchedProducts.isEmpty
                      ? const Center(child: Text("No results found"))
                      : ListView.builder(
                          padding: const EdgeInsets.all(12),
                          itemCount: providerObj.searchedProducts.length,
                          itemBuilder: (context, index) {
                            final product = providerObj.searchedProducts[index];
                            return SearchProductWidget(product: product);
                          },
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
