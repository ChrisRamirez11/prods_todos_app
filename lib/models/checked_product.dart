// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CheckedProduct {
  String name;
  String description;
  int id;
  String state;
  CheckedProduct({
    required this.name,
    required this.description,
    required this.id,
    required this.state,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'id': id,
      'state': state,
    };
  }

  factory CheckedProduct.fromMap(Map<String, dynamic> map) {
    return CheckedProduct(
      name: map['name'] as String,
      description: map['description'] as String,
      id: map['id'] as int,
      state: map['state'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CheckedProduct.fromJson(String source) => CheckedProduct.fromMap(json.decode(source) as Map<String, dynamic>);

}
