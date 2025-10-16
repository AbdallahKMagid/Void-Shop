import 'package:dio/dio.dart';
import 'package:shoppy/models/products_model.dart';

class ProductsService {
  static Dio dio = Dio();

  static Future<ProductsModel> getProducts() async {
    final response = await dio.get("https://dummyjson.com/products?limit=194");
    if (response.statusCode == 200) {
      return ProductsModel(products: response.data["products"]);
    } else {
      throw Exception("Error getting products");
    }
  }

  static Future<ProductsModel> getCategories() async {
    final response = await dio.get("https://dummyjson.com/products/categories");
    if (response.statusCode == 200) {
      return ProductsModel(categories: response.data);
    } else {
      throw Exception("Error getting categories");
    }
  }

  static Future<ProductsModel> getProductsByCategories(String category) async {
    final response = await dio.get(
      "https://dummyjson.com/products/category/$category",
    );

    if (response.statusCode == 200) {
      return ProductsModel(products: response.data["products"]);
    } else {
      throw Exception("Error getting products by category");
    }
  }

  static Future<ProductsModel> addToCart(Map item) async {
    Map data = {"id": 1, "userId": 1, "products": item};
    final response = await dio.post(
      "https://dummyjson.com/carts/add",
      data: data,
    );
    if (response.statusCode == 201) {
      return ProductsModel(cart: response.data);
    } else {
      throw Exception("Error Setting item To Cart");
    }
  }

  static Future<ProductsModel> getCart() async {
    final response = await dio.get("https://dummyjson.com/carts/1");
    if (response.statusCode == 200) {
      return ProductsModel(cart: response.data["products"]);
    } else {
      throw Exception("Error getting Cart");
    }
  }

  static Future<ProductsModel> getSearchedProducts(String searchFor) async {
    final response = await dio.get(
      "https://dummyjson.com/products/search?q=$searchFor",
    );
    if (response.statusCode == 200) {
      return ProductsModel(products: response.data["products"]);
    } else {
      throw Exception("Error getting products");
    }
  }
}
