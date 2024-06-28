// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> ingredients_list = <String>[
    "Eggs",
    "Milk",
    "Chicken Breast",
    "Flour",
    "Sugar",
    "Brown Sugar"
  ];

  List<String> selected_ingredients = <String>[];

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
      body: Column(
        children: [
          // MultiSelectDialogField(
          //   items: ingredients_list.map((e) => MultiSelectItem(e)).toList(),
          //   listType: MultiSelectListType.CHIP,
          //   onConfirm: (values) {
          //     selected_ingredients = values;
          //   },
          // ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, childAspectRatio: 1),
              padding: const EdgeInsets.all(8),
              itemCount: ingredients_list.length,
              itemBuilder: (BuildContext context, int index) {
                return TextButton(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                    ),
                    backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.pressed)) {
                          return Colors.amber;
                        }
                        return Colors.green; // Use the component's default.
                      },
                    ),
                  ),
                  onPressed: () {},
                  child: Text('Entry ${ingredients_list[index]}'),
                );
              },
            ),
          ),
          Expanded(
            child: Row(
              children: [Text("Text")],
            ),
          ),
          Expanded(
            child: Row(
              children: [Text("Text")],
            ),
          ),
          Text("Saved Recipes"),
          Container(
            margin: EdgeInsets.all(
              width * .03,
            ),
            child: Center(
              child: CarouselSlider(
                items: [
                  Column(
                    children: [
                      Text("TITLE"),
                      Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/image1.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          border: Border.all(
                            color: Color.fromARGB(255, 162, 227, 174),
                            width: 4.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("TITLE"),
                      Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/image2.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          border: Border.all(
                            color: Color.fromARGB(255, 162, 227, 174),
                            width: 4.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                options: CarouselOptions(
                  height: 150,
                  aspectRatio: 16 / 5,
                  viewportFraction: .3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
