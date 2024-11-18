import 'package:flutter/material.dart';
import 'package:prods_todos_app/models/product.dart';
import 'package:prods_todos_app/utils/theme.dart';

Widget productSimpleDialog(BuildContext context, Product product) {
  final theme = Theme.of(context).textTheme;
  Size size = MediaQuery.of(context).size;
  return SimpleDialog(contentPadding: const EdgeInsets.all(10), children: [
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Center(
        child: Text(product.name, style: theme.bodyMedium),
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Column(
        children: [
          SizedBox(
            width: size.width * 0.6,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/no-image.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            ' Descripcion: ',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            constraints: BoxConstraints(
              minHeight: 70,
              maxHeight: size.height * 0.3,
              minWidth: size.width,
            ),
            decoration: BoxDecoration(
                color: second2, borderRadius: BorderRadius.circular(10)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Text(
                  product.description,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    ),
  ]);
}
