// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class MapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Map Page')),
      body: Column(
        children: [
          Row(
            children: [
              Text("Put map here"),
              Text("Put search here"),
            ],
          )
        ],
      ),
    );
  }
}
