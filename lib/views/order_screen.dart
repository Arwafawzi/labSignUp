import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key, required this.order});

  final Map order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Card(child: Text(order["id"].toString())),
        Text(
          order["title"],
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(order["content"]),
        Text(order["create_at"]),
      ]),
    );
  }
}
