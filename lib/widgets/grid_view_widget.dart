import 'package:flutter/material.dart';
import 'package:prods_todos_app/models/pending_product.dart';
import 'package:prods_todos_app/services/prods_adapter.dart';
import 'package:prods_todos_app/services/prods_json_api.dart';
import 'package:prods_todos_app/utils/theme.dart';
import 'package:prods_todos_app/widgets/custom_error_widget.dart';
import 'package:prods_todos_app/widgets/custom_loader_widget.dart';

class GridViewWidget extends StatefulWidget {
  const GridViewWidget({super.key});

  @override
  State<GridViewWidget> createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {
  @override
  Widget build(BuildContext context) {
    ProdsJsonAPI prodsJsonAPI = ProdsJsonAPI();
    ProdsAdapter prodsAdapter = ProdsAdapter(prodsJsonAPI: prodsJsonAPI);

    return FutureBuilder<List<PendingProduct>>(
        future: prodsAdapter.getProductsFromJson(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return customErrorWidget();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return customLoaderWidget();
          } else {
            final data = snapshot.data;
            return GridView.builder(
              itemCount: data!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.9, crossAxisCount: 2),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Card(
                    elevation: 10,
                    child: InkWell(
                      onTap: () {},
                      child: _createGridContainer(context, index, data),
                    ),
                  ),
                );
              },
            );
          }
        });
  }

  _createGridContainer(BuildContext context, int index, data) {
    PendingProduct product = data[index];

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
              thickness: 0.5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:  8.0),
            child: Row(
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.cancel)),
                const Expanded(child: SizedBox()),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.check_circle_outline))
              ],
            ),
          )
        ],
      ),
    );
  }
}
