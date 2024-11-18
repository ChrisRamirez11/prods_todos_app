import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prods_todos_app/models/checked_product.dart';
import 'package:prods_todos_app/utils/theme.dart';
import 'package:prods_todos_app/widgets/custom_loader_widget.dart';

import '../provider/checked_products_provider.dart';

class RejectedProduct extends ConsumerStatefulWidget {
  const RejectedProduct({super.key});

  @override
  ConsumerState<RejectedProduct> createState() => _RejectedProductState();
}

class _RejectedProductState extends ConsumerState<RejectedProduct> {
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
                  return getListTile(context, checkedProduct, index);
                },
              ),
      ),
    );
  }
}

//TODO AnimatedList.of(context).removeItem
Widget getListTile(
    BuildContext context, CheckedProduct checkedProduct, int index) {
  return Dismissible(
    key: UniqueKey(),
    onDismissed: (direction) {
      //TODO delete from provider
    },
    child: Row(
      children: [
        Expanded(
          flex: 5,
          child: Card(
            color: second2,
            child: SizedBox(
              height: 70,
              child: InkWell(
                onTap: () {
                  AnimatedList.of(context).removeItem(
                      duration: const Duration(milliseconds: 500),
                      index, (context, animation) {
                    return SlideTransition(
                        position: animation.drive(Tween(
                            begin: const Offset(1, 0),
                            end: const Offset(0, 0))),
                        child: const Card(
                          color: Colors.red,
                          child: ListTile(
                            title: Center(child: Text('Eliminado')),
                          ),
                        ));
                        //TODO delete from provider
                  });
                },
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
                            'ID: #${checkedProduct.id}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30, child: VerticalDivider()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
