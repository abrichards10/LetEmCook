// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Favorite Page')),
      body: Column(
        children: [
          Row(
            children: [
              Text("Put favorites here"),
            ],
          )
        ],
      ),
    );
  }
}
