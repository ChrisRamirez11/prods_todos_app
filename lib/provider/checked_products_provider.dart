
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final checkedProductProvider = ChangeNotifierProvider((ref) {
  return CheckedProductsProvider();
},);

class CheckedProductsProvider extends ChangeNotifier{


}