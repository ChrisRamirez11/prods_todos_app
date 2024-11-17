import 'package:flutter/material.dart';

Widget customErrorWidget() {
  return Container(
    decoration: const BoxDecoration(boxShadow: [BoxShadow(color: Colors.black26)]),
    width: double.infinity,
    height: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            padding: const EdgeInsets.all(50),
            child: Image.asset('assets/images/error.png')),
        const Text('Ha ocurrido un error\nIntentelo mas tarde')
      ],
    ),
  );
}
