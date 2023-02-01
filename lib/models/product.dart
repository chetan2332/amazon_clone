import 'dart:convert';

import 'package:flutter/foundation.dart';

class Product {
  final String name;
  final String description;
  final List<String> images;
  final double quantity;
  final double price;
  final String category;
  final String? id;
  Product({
    required this.name,
    required this.description,
    required this.images,
    required this.quantity,
    required this.price,
    required this.category,
    this.id,
  });

  Product copyWith({
    String? name,
    String? description,
    List<String>? images,
    double? quantity,
    double? price,
    String? category,
    String? id,
  }) {
    return Product(
      name: name ?? this.name,
      description: description ?? this.description,
      images: images ?? this.images,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      category: category ?? this.category,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'images': images,
      'quantity': quantity,
      'price': price,
      'category': category,
      'id': id,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      images: List<String>.from(map['images']),
      quantity: map['quantity']?.toDouble() ?? 0.0,
      price: map['price']?.toDouble() ?? 0.0,
      category: map['category'] ?? '',
      id: map['_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(name: $name, description: $description, images: $images, quantity: $quantity, price: $price, category: $category, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.name == name &&
        other.description == description &&
        listEquals(other.images, images) &&
        other.quantity == quantity &&
        other.price == price &&
        other.category == category &&
        other.id == id;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        images.hashCode ^
        quantity.hashCode ^
        price.hashCode ^
        category.hashCode ^
        id.hashCode;
  }
}
