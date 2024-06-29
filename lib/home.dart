// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:let_em_cook/models/recipe_info.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> ingredientsList = <String>[
    "flour",
    "sugar",
    "salt",
    "butter",
    "eggs",
    "milk",
    "baking powder",
    "vanilla extract",
    "chocolate chips",
    "cocoa powder",
    "brown sugar",
    "baking soda",
    "yeast",
    "olive oil",
    "honey",
    "lemon juice",
    "garlic",
    "onion",
    "tomato",
    "carrot",
    "celery",
    "chicken broth",
    "beef broth",
    "pasta",
    "rice",
    "beans",
    "corn",
    "bell pepper",
    "cheese",
    "basil",
    "oregano",
    "thyme",
    "rosemary",
    "parsley",
    "cilantro",
    "cumin",
    "paprika",
    "cinnamon",
    "nutmeg",
    "ginger",
    "black pepper",
    "red pepper flakes"
  ];

  List<RecipeInfo> savedRecipes = <RecipeInfo>[
    RecipeInfo(
        name: "name", pictureUrl: "pictureUrl", description: "description"),
    RecipeInfo(
        name: "name", pictureUrl: "pictureUrl", description: "description"),
    RecipeInfo(
        name: "name", pictureUrl: "pictureUrl", description: "description"),
    RecipeInfo(
        name: "name", pictureUrl: "pictureUrl", description: "description"),
    RecipeInfo(
        name: "name", pictureUrl: "pictureUrl", description: "description"),
    RecipeInfo(
        name: "name", pictureUrl: "pictureUrl", description: "description"),
    RecipeInfo(
        name: "name", pictureUrl: "pictureUrl", description: "description"),
    RecipeInfo(
        name: "name", pictureUrl: "pictureUrl", description: "description"),
    RecipeInfo(
        name: "name", pictureUrl: "pictureUrl", description: "description"),
  ];

  List<String> selectedIngredients = <String>[];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        actions: [Text("Hi")],
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: Text(
          "Let 'Em Cook",
          style: TextStyle(
            fontFamily: GoogleFonts.adventPro().fontFamily,
            fontWeight: FontWeight.bold,
            fontSize: width * .08,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [_savedRecipesList(), _ingredientsList()],
        ),
      ),
    );
  }

  _savedRecipesList() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 250.0,
        aspectRatio: 16 / 9,
        viewportFraction: 0.3,
      ),
      items: savedRecipes.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Column(
              children: [
                Text("TITLE"),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 5, 5, 5),
                  width: 200.0,
                  height: 200.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/image1.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    border: Border.all(
                      color: Color.fromARGB(255, 124, 198, 218),
                      width: 4.0,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }).toList(),
    );
  }

  _ingredientsList() {
    return SizedBox(
      height: 200,
      child: Container(
        margin: EdgeInsets.all(20),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, childAspectRatio: 1),
          itemCount: ingredientsList.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return TextButton(
              onPressed: () {},
              child: Container(
                alignment: Alignment.center,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  color: Color.fromARGB(255, 124, 198, 218),
                ),
                child: Text(
                  textAlign: TextAlign.center,
                  ingredientsList[index],
                  style: TextStyle(
                    fontFamily: GoogleFonts.adventPro().fontFamily,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
