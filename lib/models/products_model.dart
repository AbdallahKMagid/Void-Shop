class ProductsModel {
  List? products;
  List? categories;
  List? cart;

  ProductsModel({this.products, this.categories, this.cart});

  factory ProductsModel.getJson({required Map json}) {
    return ProductsModel(products: json["products"]);
  }

  factory ProductsModel.getJsonCategories(List categories) {
    return ProductsModel(categories: categories);
  }

  factory ProductsModel.getJsonCart(List cart) {
    return ProductsModel(cart: cart);
  }
}
