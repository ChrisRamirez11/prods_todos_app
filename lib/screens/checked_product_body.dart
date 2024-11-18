import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prods_todos_app/models/checked_product.dart';
import 'package:prods_todos_app/utils/status.dart';
import 'package:prods_todos_app/utils/theme.dart';
import 'package:prods_todos_app/widgets/custom_loader_widget.dart';
import 'package:prods_todos_app/widgets/products_simple_dialog.dart';

import '../provider/checked_products_provider.dart';

class CheckedProducts extends ConsumerStatefulWidget {
  const CheckedProducts({super.key});

  @override
  ConsumerState<CheckedProducts> createState() => _RejectedProductState();
}

class _RejectedProductState extends ConsumerState<CheckedProducts> {
  final ScrollController _scrollController = ScrollController();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(
      () {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          log("Reached bottom of the list");
          fetchProducts();
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reference = ref.watch(checkedProductProvider);

    return Scaffold(
      body: reference.isLoading
          ? customLoaderWidget()
          : Stack(
              children: [
                ListView.builder(
                  controller: _scrollController,
                  itemCount: reference.checkedProducts.length,
                  itemBuilder: (context, index) {
                    final CheckedProduct checkedProduct =
                        reference.checkedProducts[index];
                    return getListTile(context, checkedProduct, index, ref);
                  },
                ),
                _createLoading(),
                _getFetchMore(),
              ],
            ),
    );
  }

  Future<void> fetchProducts() async {
    setState(() {
      _loading = true;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    await ref.watch(checkedProductProvider).fetchPaginated();
    setState(() {
      _loading = false;
    });
    _scrollController.animateTo(_scrollController.position.pixels + 100,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn);
  }

  Widget _createLoading() {
    if (_loading) {
      return const Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Colors.blue,
              )
            ],
          ),
          SizedBox(height: 10),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _getFetchMore() {
    if (_scrollController.positions.length <= 1) {
      return ref.read(checkedProductProvider).checkedProducts.length <= 11 ?
      Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ElevatedButton.icon(label: Text('Cargar Mas', style: Theme.of(context).textTheme.bodyMedium,),
              onPressed: () {
              fetchProducts();
            }, icon: Icon(Icons.refresh, color: greenCustom,))],
          ),
          const SizedBox(height: 20),
        ],
      ): Container();
    }
    return Container();
  }
}

Widget getListTile(BuildContext context, CheckedProduct checkedProduct,
    int index, WidgetRef ref) {
  return Dismissible(
    key: UniqueKey(),
    onDismissed: (direction) {
      ref.read(checkedProductProvider).deleteProduct(checkedProduct);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${checkedProduct.name} dismissed')),
      );
    },
    child: InkWell(
      onTap: () => showDialog(
        context: context,
        builder: (context) => productSimpleDialog(context, checkedProduct),
      ),
      child: Card(
        color:
            checkedProduct.state == Status.accepted ? greenCustom : errorColor,
        child: SizedBox(
          height: 70,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.receipt_long),
                    Text(
                      checkedProduct.state,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30, child: VerticalDivider()),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.receipt_sharp),
                    Text(
                      'Nombre: ${checkedProduct.name}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30, child: VerticalDivider()),
              Expanded(
                  flex: 1,
                  child: _buildButton(context, index, ref, checkedProduct))
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildButton(BuildContext context, int index, WidgetRef ref,
    CheckedProduct checkedProduct) {
  return IconButton(
      onPressed: () {
        ref.read(checkedProductProvider).deleteProduct(checkedProduct);
      },
      icon: const Icon(Icons.delete));
}
