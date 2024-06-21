class ProductDropdown {
  final String id;
  final String name;

  ProductDropdown({required this.id, required this.name});

  factory ProductDropdown.fromFirestore(Map<String, dynamic> data, String id) {
    return ProductDropdown(
      id: id,
      name: data['name'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
    };
  }
}
