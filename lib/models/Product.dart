import 'dart:ffi';

class Product {
  final String name;
  final String code;
  final String category;
  final String price;

  const Product({
    required this.name,
    required this.code,
    required this.category,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
      return Product(
        code: json["response"]["products"][0]['code'],
        name: json["response"]["products"][0]['name'],
        category: json["response"]["products"][0]['category'],
        price: json["response"]["products"][0]['price'],
      );
  }
}