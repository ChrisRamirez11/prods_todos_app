import 'package:prods_todos_app/models/pending_product.dart';

abstract class ProdsDataInterface {
  Future<List<PendingProduct>> getProductsFromJson();
}