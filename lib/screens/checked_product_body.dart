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
  @override
  Widget build(BuildContext context) {
    final reference = ref.watch(checkedProductProvider);

    return Scaffold(
      body: Container(
        child: reference.isLoading
            ? customLoaderWidget()
            : AnimatedList(
                initialItemCount: reference.checkedProduct.length,
                itemBuilder: (context, index, animation) {
                  final CheckedProduct checkedProduct =
                      reference.checkedProduct[index];
                  return getListTile(context, checkedProduct, index, ref);
                },
              ),
      ),
    );
  }
}

Widget getListTile(BuildContext context, CheckedProduct checkedProduct,
    int index, WidgetRef ref) {
  return Dismissible(
    key: UniqueKey(),
    onDismissed: (direction) {
      AnimatedList.of(context).removeItem(
        index,
        (context, animation) {
          return Container();
        },
      );
      ref.watch(checkedProductProvider).deleteProduct(checkedProduct);
    },
    child: InkWell(
      onTap: () => showDialog(context: context, builder: (context) => productSimpleDialog(context, checkedProduct),),
      child: Card(
        color: checkedProduct.state == Status.accepted
            ? greenCustom
            : errorColor,
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
              Expanded(flex: 1,child: _buildButton(context, index, ref, checkedProduct))
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
        AnimatedList.of(context).removeItem(
            duration: const Duration(milliseconds: 400),
            index, (context, animation) {
          return SlideTransition(
              position: animation.drive(
                  Tween(begin: const Offset(1, 0), end: const Offset(0, 0))),
              child: const Card(
                color: Colors.red,
                child: ListTile(
                  minTileHeight: 70,
                  title: Center(child: Text('Eliminado')),
                ),
              ));
        });
        ref.watch(checkedProductProvider).deleteProduct(checkedProduct);
      },
      icon: const Icon(Icons.delete));
}
