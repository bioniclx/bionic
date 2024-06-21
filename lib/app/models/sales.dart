// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bionic/app/models/product.dart';

class Sales {
  final String id;
  final String storeId;
  final String name;
  final String address;
  final String phone;
  final DateTime createdAt;
  final List<Product> products;
  final int discount;
  final int total;
  Sales({
    required this.id,
    required this.storeId,
    required this.name,
    required this.address,
    required this.phone,
    required this.createdAt,
    required this.products,
    required this.discount,
    required this.total,
  });
  factory Sales.fromJson(Map<String, dynamic> json) {
    var productsJson = json['products'] as List;
    List<Product> productsList = productsJson
        .map((productJson) => Product.fromJson(productJson))
        .toList();

    return Sales(
      id: json['id'],
      storeId: json['store_id'],
      address: json['address'],
      createdAt: DateTime.parse(json['created_at']),
      discount: json['discount'],
      name: json['name'],
      phone: json['phone'],
      products: productsList,
      total: int.parse(json['total']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'created_at': createdAt.toIso8601String(),
      'discount': discount,
      'name': name,
      'phone': phone,
      'products': products.map((product) => product.toJson()).toList(),
      'total': total.toString(),
    };
  }
}
