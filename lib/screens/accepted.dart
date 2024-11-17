import 'package:flutter/material.dart';
import 'package:prods_todos_app/widgets/custom_error_widget.dart';
import 'package:prods_todos_app/widgets/custom_loader_widget.dart';

class AcceptedOrder extends StatelessWidget {
  const AcceptedOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        //TODO
        future: ,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return customLoaderWidget();
          } else if (snapshot.hasError) {
            return customErrorWidget();
          } else {
            List<Map<String, dynamic>>? orderMap = snapshot.data;
            return ListView.builder(
              itemCount: orderMap!.length,
              itemBuilder: (context, index) =>
                  getListTile(context, orderMap[index]),
            );
          }
        },
      ),
    );
  }
}

getListTile(BuildContext context, Map<String, dynamic> orderMap) {
  DateTime date = DateTime.parse(orderMap['created_at']);
  if (!orderMap['attended']) return Container();

  return Card(
    child: SizedBox(
      height: 70,
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => FutureBuilder(
              future: orderSimpleDialog(context, orderMap),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return customErrorWidget();
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return snapshot.data!;
                }
              },
            ),
          );
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
                    'ID: #${orderMap['id'].toString()}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30, child: VerticalDivider()),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.calendar_month),
                  Text('${date.day}/${date.month}/${date.year}'),
                ],
              ),
            ),
            const SizedBox(height: 30, child: VerticalDivider()),
          ],
        ),
      ),
    ),
  );
}

