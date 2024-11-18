import 'dart:convert';
import 'package:prods_todos_app/models/product.dart';

class CheckedProduct extends Product {
  String state;

  CheckedProduct({
    required super.name,
    required super.description,
    required super.id,
    required this.state,
  });

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map['state'] = state;
    return map;
  }

  factory CheckedProduct.fromMap(Map<String, dynamic> map) {
    return CheckedProduct(
      name: map['name'] as String,
      description: map['description'] as String,
      id: map['id'] as int,
      state: map['state'] as String,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory CheckedProduct.fromJson(String source) =>
      CheckedProduct.fromMap(json.decode(source) as Map<String, dynamic>);
}