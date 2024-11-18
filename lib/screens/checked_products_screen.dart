import 'package:flutter/material.dart';
import 'package:prods_todos_app/screens/checked_products.dart';
import 'package:prods_todos_app/utils/theme.dart';

class CheckedProductScreen extends StatefulWidget {
  const CheckedProductScreen({super.key});

  @override
  State<CheckedProductScreen> createState() => _CheckedProductScreenState();
}

class _CheckedProductScreenState extends State<CheckedProductScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Pedidos Atendidos',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          foregroundColor: secondary,
          backgroundColor: primary,
        ),
        body: const CheckedProducts(),
      ),
    );
  }

}
