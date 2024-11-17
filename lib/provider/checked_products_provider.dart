import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prods_todos_app/database/checked_products_sqlite.dart';
import 'package:prods_todos_app/models/checked_product.dart';

final checkedProductProvider = ChangeNotifierProvider<CheckedProductsProvider>(
  (ref) {
    return CheckedProductsProvider();
  },
);

class CheckedProductsProvider extends ChangeNotifier {
  final List<CheckedProduct> _checkedProduct = [];
  final CheckedProductsSqlite _checkedProductsSqlite = CheckedProductsSqlite();
  
  int _count = 0;
  bool isLoading = true;

  List<CheckedProduct> get checkedProduct => _checkedProduct;

  CheckedProductsProvider() {
    _loadList();
  }

  Future<void> _loadList() async {
    _checkedProduct
        .addAll(await _checkedProductsSqlite.getPaginatedProduct(_count));
    _count += 7;
    isLoading = false;
    notifyListeners();
  }

  addProduct(CheckedProduct checkedProduct) {
    _checkedProduct.add(checkedProduct);
    _checkedProductsSqlite.addProduct(checkedProduct);
    notifyListeners();
  }
}
