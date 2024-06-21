// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductCart {
  String id;
  final String productName;
  final int productPrice;
  final int productStock;
  final String productCategory;
  final String productImage;
  late int qty;

  ProductCart({
    required this.id,
    required this.productName,
    required this.productPrice,
    required this.productStock,
    required this.productCategory,
    required this.productImage,
    required this.qty,
  });

  factory ProductCart.fromJson(Map<String, dynamic> json) {
    return ProductCart(
      id: json['id'],
      productName: json['name'],
      productPrice: json['price'],
      productStock: json['stock'],
      productCategory: json['category'],
      productImage: json['image'],
      qty: json['qty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': productName,
      'price': productPrice,
      'stock': productStock,
      'category': productCategory,
      'image': productImage,
      'qty': qty,
    };
  }

  int get totalPrice => productPrice * qty;
  int get totalStock => productStock - qty;
  void increment() {
    qty++;
  }

  void decrement() {
    qty--;
  }
}
