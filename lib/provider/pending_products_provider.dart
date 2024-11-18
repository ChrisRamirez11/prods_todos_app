import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prods_todos_app/models/product.dart';
import 'package:prods_todos_app/services/prods_adapter.dart';
import 'package:prods_todos_app/services/prods_json_api.dart';

final pendingProductProvider = ChangeNotifierProvider<PendingProductsProvider>(
  (ref) {
    return PendingProductsProvider();
  },
);

class PendingProductsProvider extends ChangeNotifier {
  final List<Product> _pendingProduct = [];
  ProdsJsonAPI prodsJsonAPI = ProdsJsonAPI();
  bool isLoading = true;

  List<Product> get pendingProduct => _pendingProduct;

  PendingProductsProvider() {
    _loadList();
  }

  Future<void> _loadList() async {
    log('message');
    ProdsAdapter prodsAdapter = ProdsAdapter(prodsJsonAPI: prodsJsonAPI);
    _pendingProduct.addAll(await prodsAdapter.getProductsFromJson());
    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteProduct(Product pp) async {
    log('here');
    await prodsJsonAPI.deleteProduct(pp);
    _pendingProduct.removeWhere(
      (element) => element.id == pp.id,
    );
    isLoading = false;
    notifyListeners();
  }
}