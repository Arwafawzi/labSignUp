import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardOrders extends StatelessWidget {
  const CardOrders({super.key, required this.order});
  final Map order;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(order["title"], style: TextStyle(color: Colors.amber)),
        subtitle: Text(order["content"]),
        trailing: Text(order["create_at"]),
      ),
    );
  }
}
