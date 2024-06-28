// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        actions: [Text("Hi")],
        backgroundColor: Color.fromARGB(255, 162, 227, 174),
        title: Text(
          "Let 'Em Cook",
          style: TextStyle(
            fontFamily: GoogleFonts.adventPro().fontFamily,
            fontWeight: FontWeight.bold,
            fontSize: width * .08,
          ),
        ),
      ),
      body: Container(
          child: Column(
        children: [
          Center(
            child: CarouselSlider(
              items: [
                Image(image: AssetImage('assets/image1.jpg')),
                Image(image: AssetImage('assets/image2.jpg')),
                Image(image: AssetImage('assets/image3.jpg')),
                Image(image: AssetImage('assets/image4.jpg'))
              ],
              options: CarouselOptions(height: 100.0),
            ),
          ),
          Row(
            children: [Text("Text")],
          ),
          Row(children: [Text("Text")])
        ],
      )),
    );
  }
}
