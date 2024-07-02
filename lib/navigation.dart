// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:let_em_cook/favorite.dart';
import 'package:let_em_cook/home_screen.dart';
import 'package:let_em_cook/map.dart';
import 'package:let_em_cook/order.dart';
import 'package:let_em_cook/shopping.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({
    super.key,
  });

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentIndex = 2; // Start with HomePage
  final List<Widget> _pages = [
    OrderPage(),
    FavoritePage(),
    MainPage(),
    MapPage(),
    ShoppingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.white,
        fixedColor: Colors.white,
        selectedFontSize: 0,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.phone,
              color: Color.fromARGB(255, 33, 78, 35),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: Color.fromARGB(255, 33, 78, 35),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Color.fromARGB(255, 33, 78, 35),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.map,
              color: Color.fromARGB(255, 33, 78, 35),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_bag_outlined,
              color: Color.fromARGB(255, 33, 78, 35),
            ),
            label: "",
          )
        ],
      ),
    );
  }
}
