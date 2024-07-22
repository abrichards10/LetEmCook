// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:let_em_cook/bloc/home_bloc.dart';
import 'package:let_em_cook/database_helper.dart';
import 'package:let_em_cook/models/recipe_info.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _noRecipesInList = false; // TODO: change

  List<String> ingredientsList = <String>[
    "🌾 flour",
    "🍬 sugar",
    "🧂 salt",
    "🧈 butter",
    "🥚 eggs",
    "🥛 milk",
    "🧁 baking powder",
    "🍦 vanilla extract",
    "🍫 chocolate chips",
    "🍫 cocoa powder",
    "🍯 brown sugar",
    "🥤 baking soda",
    "🍞 yeast",
    "🫒 olive oil",
    "🍯 honey",
    "🍋 lemon juice",
    "🧄 garlic",
    "🧅 onion",
    "🍅 tomato",
    "🥕 carrot",
    "🥬 celery",
    "🍗 chicken broth",
    "🥩 beef broth",
    "🍝 pasta",
    "🍚 rice",
    "🫘 beans",
    "🌽 corn",
    "🫑 bell pepper",
    "🧀 cheese",
    "🌿 basil",
    "🌿 oregano",
    "🌿 thyme",
    "🌿 rosemary",
    "🌿 parsley",
    "🌿 cilantro",
    "🌿 cumin",
    "🌶️ paprika",
    "🥮 cinnamon",
    "🍂 nutmeg",
    "🍠 ginger",
    "🧂 black pepper",
    "🌶️ red pepper flakes"
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

  List<RecipeInfo> searchedRecipeResults = <RecipeInfo>[
    RecipeInfo(
        name: "name", pictureUrl: "pictureUrl", description: "description"),
    RecipeInfo(
        name: "name", pictureUrl: "pictureUrl", description: "description"),
    RecipeInfo(
        name: "name", pictureUrl: "pictureUrl", description: "description"),
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    selectedIngredients = [];

    if (selectedIngredients.isEmpty) {
      context.read<HomeBloc>().add(NoRecipesFoundEvent());
    }
    return BlocListener<HomeBloc, HomeStates>(
      listener: (context, state) {
        _blocListener(state);
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(
                Icons.account_circle_outlined,
                color: Color.fromARGB(255, 16, 84, 34),
              ),
              onPressed: () {},
            )
          ],
          leading: IconButton(
            icon: Icon(
              Icons.menu_rounded,
              color: Color.fromARGB(255, 16, 84, 34),
            ),
            onPressed: () {},
          ),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
        ),
        body: Container(
          height: height - 50,
          child: Column(
            children: [
              _savedRecipesList(),
              Divider(
                color: Color.fromARGB(150, 144, 208, 156),
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),
              Expanded(
                child: _searchedRecipesResults(),
              ),
              Divider(
                color: Color.fromARGB(150, 144, 208, 156),
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),
              Expanded(
                child: _ingredientsList(),
              ),

              // Expanded(
              _searchRecipesButton(context),
            ],
          ),
        ),
      ),
    );
  }

  _blocListener(state) {
    if (state == NoRecipesFoundState()) {
      print("Got to here");
      setState(() {
        _noRecipesInList = true;
      });
    }
    if (state == ToggleIngredientState) {
      if (ingredientsList.contains(state.ingredient)) {
        print("removed ingredient from list");
        ingredientsList.remove(state.ingredient);
      } else {
        print("added ingredient to list");
        ingredientsList.add(state.ingredient);
      }
      setState(() {});
    }
  }

  Container _savedRecipesList() {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        0,
        20,
        0,
      ),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 200.0,
          aspectRatio: 16 / 9,
          viewportFraction: 0.35,
        ),
        items: savedRecipes.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    width: 100.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                        image: AssetImage('assets/image1.jpg'),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(150, 144, 208, 156),
                          offset: Offset(
                            5,
                            5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "TITLE",
                    style: TextStyle(
                      fontFamily: GoogleFonts.adventPro().fontFamily,
                    ),
                  ),
                ],
              );
            },
          );
        }).toList(),
      ),
    );
  }

  _searchedRecipesResults() {
    return GridView.builder(
      itemCount: searchedRecipeResults.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 10,
        crossAxisCount: 2,
        childAspectRatio: 1,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              width: 108.0,
              height: 108.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                  image: AssetImage('assets/image2.jpg'),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(150, 144, 208, 156),
                    offset: Offset(
                      5,
                      5,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "TITLE",
              style: TextStyle(
                fontFamily: GoogleFonts.adventPro().fontFamily,
              ),
            ),
          ],
        );
      },
    );
  }

  SizedBox _ingredientsList() {
    return SizedBox(
      // height: 200,
      child: Container(
        margin: EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1.5,
          ),
          itemCount: ingredientsList.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return TextButton(
              onPressed: () {
                context
                    .read<HomeBloc>()
                    .add(ToggleIngredientEvent(ingredientsList[index]));
              },
              child: Container(
                alignment: Alignment.center,
                height: 44,
                decoration: BoxDecoration(
                  color: true // TODO: CHANGE
                      ? Colors.white
                      : Color.fromARGB(150, 144, 208, 156),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(150, 144, 208, 156),
                      offset: Offset(
                        5,
                        5,
                      ),
                    ),
                  ],
                ),
                child: Text(
                  textAlign: TextAlign.center,
                  ingredientsList[index],
                  style: TextStyle(
                    fontFamily: GoogleFonts.adventPro().fontFamily,
                    color: const Color.fromARGB(255, 61, 61, 61),
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

  _searchRecipesButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextButton(
        onPressed: () {},
        style: ButtonStyle(
          padding: WidgetStateProperty.all(EdgeInsets.fromLTRB(30, 0, 30, 0)),
          backgroundColor: WidgetStateProperty.all<Color>(
            Color.fromARGB(150, 144, 208, 156),
          ),
          foregroundColor: WidgetStateProperty.all<Color>(
            Colors.white,
          ),
        ),
        child: Text(
          "Search",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.adventPro().fontFamily,
            color: Color.fromARGB(255, 16, 84, 34),
          ),
        ),
      ),
    );
  }
}
