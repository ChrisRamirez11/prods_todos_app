import 'dart:convert';

import 'package:prods_todos_app/models/pending_product.dart';

import 'package:prods_todos_app/services/prods_data_interface.dart';
import 'package:prods_todos_app/services/prods_json_api.dart';

class ProdsAdapter implements ProdsDataInterface {
  ProdsJsonAPI? prodsJsonAPI;

  ProdsAdapter({this.prodsJsonAPI});

  @override
  Future<List<PendingProduct>> getProductsFromJson() async {
    List<dynamic> list =
        jsonDecode(await prodsJsonAPI!.fetchProducts()) as List<dynamic>;
    List<PendingProduct> res = list
        .map(
          (e) => PendingProduct.fromMap(e),
        )
        .toList();
    return res;
  }
}
