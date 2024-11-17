import 'package:flutter/material.dart';
import 'package:prods_todos_app/widgets/custom_error_widget.dart';
import 'package:prods_todos_app/widgets/custom_loader_widget.dart';

class RejectedProduct extends StatefulWidget {
  const RejectedProduct({super.key});

  @override
  State<RejectedProduct> createState() => _RejectedProductState();
}

class _RejectedProductState extends State<RejectedProduct> {
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

getListTile(
    BuildContext context, Map<String, dynamic> orderMap) {
  DateTime date = DateTime.parse(orderMap['created_at']);
  if (orderMap['attended']) return Container();
  return Row(
    children: [
      Expanded(
          flex: 5,
          child: Card(
            child: SizedBox(
              height: 70,
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => FutureBuilder(
                      //TODO
                      future: ,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('Ha ocurrido un error'),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
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
                          const Expanded(flex: 1, child: Icon(Icons.calendar_month)),
                          Expanded(
                              flex: 2,
                              child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Text(
                                      '${date.day}/${date.month}/${date.year}'))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30, child: VerticalDivider()),
                    
                  ],
                ),
              ),
            ),
          )),
    ],
  );
}

