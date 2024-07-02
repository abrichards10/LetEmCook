// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Order Page')),
      body: Column(
        children: [
          Row(
            children: [
              Text("Put order option here"),
            ],
          )
        ],
      ),
    );
  }
}
