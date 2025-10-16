class ProductsModel {
  List? products;
  List? categories;
  List? cart;

  ProductsModel({this.products, this.categories, this.cart});

  factory ProductsModel.getJson({required dynamic json}) {
    return ProductsModel(products: json["products"]);
  }

  factory ProductsModel.getJsonCategories(dynamic categories) {
    return ProductsModel(categories: categories);
  }

  factory ProductsModel.getJsonCart(dynamic cart) {
    return ProductsModel(cart: cart);
  }
}
