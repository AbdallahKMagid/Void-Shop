import 'package:flutter/widgets.dart';
import 'package:shoppy/models/products_model.dart';
import 'package:shoppy/services/products_service.dart';

class ProductProvider extends ChangeNotifier {
  ProductsModel? productsModel;
  ProductsModel? cartModel;
  String? selectedImage;
  bool isLoading = false;
  int currentIndex = 0;
  List cartId = [];
  List cart = [];
  List searchedProducts = [];
  bool isSearching = false;
  String currentSortOption = "none";
  ProductsModel? categoryProductsModel;

  void setCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  Future fetchProducts() async {
    if (isLoading) return null;
    isLoading = true;
    notifyListeners();
    try {
      final data = await ProductsService.getProducts();
      productsModel = data;
    } catch (e) {
      print("Error fetching products: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  void setImage(String image) {
    selectedImage = image;
    notifyListeners();
  }

  void clearSelectedImage() {
    selectedImage = null;
    notifyListeners();
  }

  Future<List> fetchCategories() async {
    try {
      final response = await ProductsService.getCategories();

      if (response.categories != null && response.categories!.isNotEmpty) {
        productsModel = response;
        notifyListeners();
        return response.categories!;
      } else {
        debugPrint("Unexpected categories response: ${response.categories}");
        return [];
      }
    } catch (e) {
      debugPrint("Error fetching categories: $e");
      return [];
    }
  }

  Future fetchProductsByCategories(String category) async {
    if (isLoading) return null;
    isLoading = true;
    notifyListeners();
    try {
      final data = await ProductsService.getProductsByCategories(category);
      categoryProductsModel = data;
    } catch (e) {
      print("Error fetching products: $e");
    }
    isLoading = false;
    notifyListeners();
  }

  Future getCart() async {
    cartModel = await ProductsService.getCart();
    notifyListeners();
  }

  Future addCart({required Map item}) async {
    cart.add(item);
    await ProductsService.addToCart(item);
    notifyListeners();
  }

  void increaseQuantity(Map item) {
    int index = cart.indexWhere((product) => product["id"] == item["id"]);
    if (index != -1) {
      cart[index]["quantity"] += 1;
      notifyListeners();
    }
  }

  void decreaseQuantity(Map item) {
    int index = cart.indexWhere((product) => product["id"] == item["id"]);
    if (index != -1 && cart[index]["quantity"] > 1) {
      cart[index]["quantity"] -= 1;
      notifyListeners();
    }
  }

  double getTotalPrice() {
    double total = 0;
    for (var item in cart) {
      total = total + (item["price"] * item["quantity"]);
    }
    return total;
  }

  void removeItem(int index) {
    cart.removeAt(index);
    notifyListeners();
  }

  Future<void> searchProducts(String search) async {
    try {
      isSearching = true;
      notifyListeners();

      final response = await ProductsService.getSearchedProducts(search);

      searchedProducts = response.products ?? [];
    } catch (e) {
      print("Error in searchProducts: $e");
      searchedProducts = [];
    } finally {
      isSearching = false;
      notifyListeners();
    }
  }

  void clearSearchResults() {
    searchedProducts = [];
    notifyListeners();
  }

  void sortProducts(String option) {
    currentSortOption = option;
    if (productsModel == null || productsModel!.products!.isEmpty) return;

    if (option == 'title') {
      productsModel!.products!.sort(
        (a, b) => a['title'].toString().compareTo(b['title'].toString()),
      );
    } else if (option == 'price') {
      productsModel!.products!.sort(
        (a, b) => a['price'].toDouble().compareTo(b['price'].toDouble()),
      );
    }
    notifyListeners();
  }
}
