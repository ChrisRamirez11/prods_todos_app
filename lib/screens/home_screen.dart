import 'package:flutter/material.dart';
import 'package:prods_todos_app/screens/checked_products_screen.dart';
import 'package:prods_todos_app/utils/theme.dart';
import 'package:prods_todos_app/widgets/grid_view_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CheckedProductScreen(),
                  ));
                },
                icon: const Icon(Icons.manage_history))
          ],
          centerTitle: true,
          title: Text(
            'Inicio',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          foregroundColor: secondary,
          backgroundColor: primary,
        ),
        body: const GridViewWidget(),
      ),
    );
  }
}
