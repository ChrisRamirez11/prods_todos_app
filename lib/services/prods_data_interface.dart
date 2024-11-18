import 'package:prods_todos_app/models/product.dart';

abstract class ProdsDataInterface {
  Future<List<Product>> getProductsFromJson();
}