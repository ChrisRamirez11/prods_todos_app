import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prods_todos_app/database/checked_products_sqlite.dart';
import 'package:prods_todos_app/models/checked_product.dart';

final checkedProductProvider = ChangeNotifierProvider<ProductsProvider>(
  (ref) {
    return ProductsProvider();
  },
);

class ProductsProvider extends ChangeNotifier {
  final List<CheckedProduct> _checkedProduct = [];
  final ProductsSqlite _checkedProductsSqlite = ProductsSqlite();
  
  int _count = 1;
  bool isLoading = true;

  List<CheckedProduct> get checkedProduct => _checkedProduct;

  ProductsProvider() {
    _loadList();
  }

  Future<void> _loadList() async {
    _checkedProduct
        .addAll(await _checkedProductsSqlite.getPaginatedProduct(_count));
    _count += 7;
    isLoading = false;
    notifyListeners();
  }

  addProduct(CheckedProduct checkedProduct) async {
    await _checkedProductsSqlite.addProduct(checkedProduct);
    notifyListeners();
  }

  deleteProduct(CheckedProduct checkedProduct) async {
    await _checkedProductsSqlite.deleteProduct(checkedProduct.id!);
    _checkedProduct.removeWhere((element) => element.id == checkedProduct.id,);
    notifyListeners();
  }
}
