import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prods_todos_app/models/checked_product.dart';
import 'package:prods_todos_app/models/product.dart';
import 'package:prods_todos_app/provider/checked_products_provider.dart';
import 'package:prods_todos_app/provider/pending_products_provider.dart';
import 'package:prods_todos_app/utils/status.dart';
import 'package:prods_todos_app/utils/theme.dart';
import 'package:prods_todos_app/widgets/custom_loader_widget.dart';
import 'package:prods_todos_app/widgets/products_simple_dialog.dart';

class GridViewWidget extends ConsumerStatefulWidget {
  const GridViewWidget({super.key});

  @override
  ConsumerState<GridViewWidget> createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends ConsumerState<GridViewWidget> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(pendingProductProvider).isLoading
        ? customLoaderWidget()
        : _getAnimatedList();
  }

  Widget _getAnimatedList() {
    return AnimatedGrid(
      initialItemCount: ref.watch(pendingProductProvider).pendingProduct.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.9, crossAxisCount: 2),
      itemBuilder: (context, index, animation) {
        final Product product =
            ref.watch(pendingProductProvider).pendingProduct[index];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Card(
            elevation: 10,
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => productSimpleDialog(context, product),
                );
              },
              child: _createGridContainer(context, index, ref, product),
            ),
          ),
        );
      },
    );
  }

  _createGridContainer(
      BuildContext context, int index, WidgetRef ref, Product product) {
    return Container(
      height: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: second2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 5),
              child: Center(
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        'assets/images/no-image.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                product.name,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          const Center(
            child: Divider(
              indent: 10,
              endIndent: 10,
              thickness: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                IconButton(
                    onPressed: () async {
                      if (mounted) {
                        // ignore: use_build_context_synchronously
                        AnimatedGrid.of(context).removeItem(
                          duration: const Duration(milliseconds: 600),
                          index,
                          (context, animation) {
                            return FadeTransition(
                                opacity: animation,
                                child: Card(
                                  color: errorColor,
                                  child: const ListTile(
                                    title: Center(child: Text('Rechazado')),
                                  ),
                                ));
                          },
                        );
                        await ref
                            .watch(pendingProductProvider)
                            .deleteProduct(product);

                        CheckedProduct checkedProduct = CheckedProduct(
                            name: product.name,
                            description: product.description,
                            state: Status.canceled);
                        ref
                            .watch(checkedProductProvider)
                            .addProduct(checkedProduct);
                      }
                    },
                    icon: const Icon(Icons.cancel)),
                const Expanded(child: SizedBox()),
                IconButton(
                    onPressed: () async {
                      if (mounted) {
                        // ignore: use_build_context_synchronously
                        AnimatedGrid.of(context).removeItem(
                          duration: const Duration(milliseconds: 600),
                          index,
                          (context, animation) {
                            return FadeTransition(
                                opacity: animation,
                                child: Card(
                                  color: greenCustom,
                                  child: const ListTile(
                                    title: Center(child: Text('Aprobado')),
                                  ),
                                ));
                          },
                        );
                        await ref
                            .watch(pendingProductProvider)
                            .deleteProduct(product);
                        CheckedProduct checkedProduct = CheckedProduct(
                            name: product.name,
                            description: product.description,
                            state: Status.accepted);
                        ref
                            .watch(checkedProductProvider)
                            .addProduct(checkedProduct);
                      }
                    },
                    icon: const Icon(Icons.check_circle_outline))
              ],
            ),
          )
        ],
      ),
    );
  }
}
