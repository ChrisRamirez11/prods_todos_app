import 'package:flutter/material.dart';
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

      return FutureBuilder<List<Map<String, dynamic>>>(
          //TODO
          future: ,
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
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                      elevation: 10,
                      child: InkWell(
                        onTap: () {
                        },
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
  ThemeProvider theme = Provider.of<ThemeProvider>(context);

  return Container(
    height: double.maxFinite,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      color: theme.themeData ? second2 : secondary.withAlpha(100),
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
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  height: double.maxFinite,
                  width: double.maxFinite,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset('assets/images/no-image.png'),
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
        Center(
          child: Divider(
            color: theme.themeData ? white : Colors.black,
            indent: 10,
            endIndent: 10,
            thickness: 0.5,
          ),
        ),
        Expanded(
          flex: 4,
          child: Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        '#${product.type}',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: theme.themeData
                                ? greenCustom
                                : Colors.green.shade900),
                      ),
                    ),
                    SizedBox(
                      width: 90,
                      child: Text(
                        '\$${product.price.toString()}',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(right: 1, bottom: 5),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: primary,
                    ),
                    child: IconButton(
                      color: white,
                      onPressed: () {
                      },
                      icon: const Icon(
                        Icons.add_shopping_cart_outlined,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 3,
        )
      ],
    ),
  );
}

}
