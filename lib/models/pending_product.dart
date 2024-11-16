// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PendingProduct {
  String name;
  String description;
  int id;
  PendingProduct({
    required this.name,
    required this.description,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'id': id,
    };
  }

  factory PendingProduct.fromMap(Map<String, dynamic> map) {
    return PendingProduct(
      name: map['name'] as String,
      description: map['description'] as String,
      id: int.parse(map['id']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PendingProduct.fromJson(String source) =>
      PendingProduct.fromMap(json.decode(source) as Map<String, dynamic>);
}
