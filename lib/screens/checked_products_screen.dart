import 'package:flutter/material.dart';
import 'package:prods_todos_app/screens/accepted.dart';
import 'package:prods_todos_app/screens/rejected.dart';
import 'package:prods_todos_app/utils/theme.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    String appBarTitle = 'Pedidos';
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: getBottomNavigatioBar(),
        appBar: AppBar(
          title: Text(
            appBarTitle,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          foregroundColor: secondary,
          backgroundColor: primary,
        ),
        body: callPage(currentIndex),
      ),
    );
  }

  getBottomNavigatioBar() {
    return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt), label: 'Pendiente'),
          BottomNavigationBarItem(
              icon: Icon(Icons.fact_check), label: 'Atendido'),
        ]);
  }

  callPage(int actualPage) {
    switch (actualPage) {
      case 0:
        return const RejectedProduct();
      case 1:
        return const AcceptedOrder();

      default:
        return const RejectedProduct();
    }
  }
}
