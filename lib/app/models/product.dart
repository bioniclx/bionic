class Product {
  String id;
  final String storeId;
  final String productName;
  final int productPrice;
  final int productStock;
  final String productCategory;

  Product({
    this.id = "",
    required this.storeId,
    required this.productName,
    required this.productPrice,
    required this.productStock,
    required this.productCategory,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      storeId: json['store_id'],
      productName: json['name'],
      productPrice: json['price'],
      productStock: json['stock'],
      productCategory: json['category'],
    );
  }
}
