import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';

class Sale {
  late String storeId;
  String total;
  String address;
  String discount;
  String name;
  String phone;
  DateTime createdAt;
  List<Products> products;

  Sale({
    this.storeId = "",
    required this.total,
    required this.address,
    required this.discount,
    required this.name,
    required this.phone,
    required this.createdAt,
    required this.products,
  });

  factory Sale.fromJson(Map<String, dynamic> json) {
    List<dynamic> productsJson = json['products'];
    List<Products> products = productsJson.map((productJson) {
      return Products.fromJson(productJson);
    }).toList();

    return Sale(
      storeId: json["store_id"],
      total: json["total"],
      address: json["address"],
      discount: json["discount"],
      name: json["name"],
      phone: json["phone"],
      createdAt: (json['created_at'] != null)
          ? (json['created_at'] as Timestamp).toDate()
          : DateTime.now(),
      products: products,
    );
  }

  Map<String, dynamic> toJson() => {
        "store_id": storeId,
        "total": total,
        "address": address,
        "discount": discount,
        "name": name,
        "phone": phone,
        'created_at': Timestamp.fromDate(createdAt),
        "products": products.map((product) => product.toJson()).toList(),
      };
}

class Products {
  String category;
  String id;
  String image;
  String name;
  int price;
  int qty;
  int stock;

  Products({
    required this.category,
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.qty,
    required this.stock,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        category: json["category"],
        id: json["id"],
        image: json["image"],
        name: json["name"],
        price: json["price"],
        qty: json["qty"],
        stock: json["stock"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "id": id,
        "image": image,
        "name": name,
        "price": price,
        "qty": qty,
        "stock": stock,
      };
}
