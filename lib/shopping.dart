import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:let_em_cook/database_helper.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShoppingPage(),
    );
  }
}

class ShoppingPage extends StatefulWidget {
  @override
  _ShoppingListPage createState() => _ShoppingListPage();
}

class _ShoppingListPage extends State<ShoppingPage> {
  final List<String> items = [
    '🍏 Apples',
    '🥑 Avocados',
    '🥯 Bagels',
    '🥖 Baguette',
    '🍌 Bananas',
    '🥩 Beef',
    '🫑 Bell Peppers',
    '🥦 Broccoli',
    '🧈 Butter',
    '🍬 Candy',
    '🥕 Carrots',
    '🧀 Cheese',
    '🌰 Chestnuts',
    '🍗 Chicken',
    '🍒 Cherries',
    '🍫 Chocolate',
    '🥢 Chopsticks',
    '🥥 Coconut',
    '☕ Coffee',
    '🍪 Cookies',
    '🌽 Corn',
    '🥒 Cucumbers',
    '🧁 Cupcakes',
    '🍆 Eggplants',
    '🥚 Eggs',
    '🐟 Fish',
    '🍴 Forks',
    '🧄 Garlic',
    '🍇 Grapes',
    '🍯 Honey',
    '🧊 Ice',
    '🧃 Juice',
    '🍋 Lemons',
    '🥬 Lettuce',
    '🍭 Lollipops',
    '🍈 Melons',
    '🥛 Milk',
    '🧅 Onions',
    '🍊 Oranges',
    '🍝 Pasta',
    '🍑 Peaches',
    '🥜 Peanuts',
    '🍐 Pears',
    '🥧 Pie',
    '🍍 Pineapples',
    '🍽 Plates',
    '🍿 Popcorn',
    '🥔 Potatoes',
    '🍎 Red Apples',
    '🍚 Rice',
    '🧂 Salt',
    '🥤 Soda',
    '🥄 Spoons',
    '🍓 Strawberries',
    '🧉 Sugar',
    '🍠 Sweet Potatoes',
    '🍵 Tea',
    '🍅 Tomatoes',
    '🍶 Vinegar',
    '🍉 Watermelon',
    '🍞 Whole Wheat Bread',
    '🥒 Zucchini',
  ];

  final dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> _items = [];

  @override
  void initState() {
    super.initState();
    _refreshItems();
  }

  void _clearItems() async {
    await dbHelper.deleteAllItems();
    _refreshItems();
  }

  void _refreshItems() async {
    final data = await dbHelper.queryAllItems();
    setState(() {
      _items = data;
      print("ITEMS: $_items");
    });
  }

  void _addItem(String name) async {
    await dbHelper.insertItem({'name': name});
    _refreshItems();
  }

  void _updateItem(int id, String name) async {
    await dbHelper.updateItem({'id': id, 'name': name});
    _refreshItems();
  }

  void _deleteItem(String name) async {
    await dbHelper.deleteItem(name);
    _refreshItems();
  }

  @override
  Widget build(BuildContext context) {
    // _clearItems();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text('Groceries'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ElevatedButton.icon(
            onPressed: () {
              // Show dialog or navigate to a screen to add custom ingredient
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  // TODO: Quantitty Slider
                  String customIngredient = '';
                  return AlertDialog(
                    title: Center(
                      child: Text(
                        'Add Custom Grocery',
                        style: TextStyle(
                          color: Colors.green,
                          fontFamily: GoogleFonts.adventPro().fontFamily,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    content: TextField(
                      onChanged: (value) {
                        customIngredient = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter custom ingredient',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 161, 161, 161),
                          // fontFamily: GoogleFonts.adventPro().fontFamily,
                        ),
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            // fontFamily: GoogleFonts.adventPro().fontFamily,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text(
                          'Add',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            // fontFamily: GoogleFonts.adventPro().fontFamily,
                          ),
                        ),
                        onPressed: () {
                          if (customIngredient.isNotEmpty) {
                            Provider.of<CartModel>(context, listen: false)
                                .addItem(customIngredient);
                            _addItem(customIngredient); // Add this line
                          }
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(
              Icons.add,
              color: Colors.green,
            ),
            label: Text(
              'Add Custom Grocery',
              style: TextStyle(
                color: Colors.green,
              ),
            ),
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
              Colors.white,
            )),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Consumer<CartModel>(
                  builder: (context, cart, child) {
                    final isInCart = cart.items.contains(items[index]);
                    return GestureDetector(
                      child: Container(
                        color: isInCart
                            ? Color.fromARGB(149, 168, 244, 182)
                            : Colors.white,
                        child: ListTile(
                          title: Text(items[index]),
                          trailing: Icon(
                            isInCart ? Icons.check : Icons.add,
                            color: isInCart ? Colors.green : Colors.black,
                          ),
                          onTap: () {
                            if (isInCart) {
                              cart.removeItem(items[index]);
                              _deleteItem(items[index]); // Change this line
                            } else {
                              cart.addItem(items[index]);
                              _addItem(items[index]); // Change this line
                            }
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          return ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(cart.items[index]),
                trailing: IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    cart.removeItem(cart.items[index]);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CartModel extends ChangeNotifier {
  final List<String> _items = [];
  final DatabaseHelper dbHelper = DatabaseHelper();

  CartModel() {
    _initializeCart();
  }

  List<String> get items => _items;

  void addItem(String item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(String item) async {
    _items.remove(item);
    await dbHelper.deleteItem(item);
    notifyListeners();
  }

  void _initializeCart() async {
    final data = await dbHelper.queryAllItems();
    _items.addAll(data.map((item) => item['name'] as String));
    notifyListeners();
  }
}
