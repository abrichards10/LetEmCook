import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:let_em_cook/database_helper.dart';

import 'package:provider/provider.dart';

class GroceriesPage extends StatefulWidget {
  @override
  _GroceriesPageState createState() => _GroceriesPageState();
}

class _GroceriesPageState extends State<GroceriesPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _customIngredientController =
      TextEditingController();

  // List<String> items = [
  //   '🍏 Apples',
  //   '🥑 Avocados',
  //   '🥯 Bagels',
  //   '🥖 Baguette',
  //   '🍌 Bananas',
  //   '🥩 Beef',
  //   '🫑 Bell Peppers',
  //   '🥦 Broccoli',
  //   '🧈 Butter',
  //   '🍬 Candy',
  //   '🥕 Carrots',
  //   '🧀 Cheese',
  //   '🌰 Chestnuts',
  //   '🍗 Chicken',
  //   '🍒 Cherries',
  //   '🍫 Chocolate',
  //   '🥢 Chopsticks',
  //   '🥥 Coconut',
  //   '☕ Coffee',
  //   '🍪 Cookies',
  //   '🌽 Corn',
  //   '🥒 Cucumbers',
  //   '🧁 Cupcakes',
  //   '🍆 Eggplants',
  //   '🥚 Eggs',
  //   '🐟 Fish',
  //   '🍴 Forks',
  //   '🧄 Garlic',
  //   '🍇 Grapes',
  //   '🍯 Honey',
  //   '🧊 Ice',
  //   '🧃 Juice',
  //   '🍋 Lemons',
  //   '🥬 Lettuce',
  //   '🍭 Lollipops',
  //   '🍈 Melons',
  //   '🥛 Milk',
  //   '🧅 Onions',
  //   '🍊 Oranges',
  //   '🍝 Pasta',
  //   '🍑 Peaches',
  //   '🥜 Peanuts',
  //   '🍐 Pears',
  //   '🥧 Pie',
  //   '🍍 Pineapples',
  //   '🍽 Plates',
  //   '🍿 Popcorn',
  //   '🥔 Potatoes',
  //   '🍎 Red Apples',
  //   '🍚 Rice',
  //   '🧂 Salt',
  //   '🥤 Soda',
  //   '🥄 Spoons',
  //   '🍓 Strawberries',
  //   '🧉 Sugar',
  //   '🍠 Sweet Potatoes',
  //   '🍵 Tea',
  //   '🍅 Tomatoes',
  //   '🍶 Vinegar',
  //   '🍉 Watermelon',
  //   '🍞 Whole Wheat Bread',
  //   '🥒 Zucchini',
  // ];

  final dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> _items = [];

  bool _isSorted = false;

  @override
  void initState() {
    super.initState();
    _refreshItems();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _clearItems() async {
    await dbHelper.deleteAllItems();
  }

  void _refreshItems() async {
    final data = await dbHelper.queryAllItems();
    setState(() {
      _items = List<Map<String, dynamic>>.from(data);
      print("ITEMS: $_items");
    });
  }

  void _addItem(String name) async {
    await dbHelper.insertItem({'name': name});
    _refreshItems();
  }

  void _deleteItem(String name) async {
    await dbHelper.deleteItem(name);
    _refreshItems();
  }

  void _toggleSort() {
    setState(() {
      _items.sort((a, b) {
        bool aInCart = Provider.of<CartModel>(context, listen: false)
            ._items
            .contains(a['name']);
        bool bInCart = Provider.of<CartModel>(context, listen: false)
            ._items
            .contains(b['name']);
        return aInCart == bInCart ? 0 : (aInCart ? -1 : 1);
      });
    });

    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      title: Text(
        'Groceries',
        style: TextStyle(
          fontFamily: GoogleFonts.adventPro().fontFamily,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  _addCustomGroceryButton() {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 0, 20, 5),
      child: ElevatedButton.icon(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
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
                  controller: _customIngredientController,
                  onChanged: (value) {
                    customIngredient = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter custom ingredient',
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 161, 161, 161),
                    ),
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      'Close',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
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
                      ),
                    ),
                    onPressed: () {
                      if (customIngredient.isNotEmpty) {
                        // Add the custom item to the database
                        _addItem(customIngredient);

                        // Clear the text field
                        _customIngredientController.clear();

                        // Optionally notify user of the addition
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('$customIngredient added'),
                          ),
                        );
                        customIngredient = "";
                      }
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
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.adventPro().fontFamily,
            color: Colors.green,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            Colors.white,
          ),
        ),
      ),
    );
  }

  _showAddedButton() {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 0, 20, 5),
      child: ElevatedButton.icon(
        onPressed: _toggleSort,
        icon: Icon(
          Icons.arrow_upward,
          color: Colors.green,
        ),
        label: Text(
          'Show Added',
          style: TextStyle(
            color: Colors.green,
            fontFamily: GoogleFonts.adventPro().fontFamily,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
          Colors.white,
        )),
      ),
    );
  }

  _individualIngredient(isInCart, index, cart) {
    return GestureDetector(
      child: Container(
        color: isInCart ? Color.fromARGB(149, 168, 244, 182) : Colors.white,
        child: ListTile(
          title: Text(
            _items[index]['name'],
            style: TextStyle(
              fontFamily: GoogleFonts.adventPro().fontFamily,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Icon(
            isInCart ? Icons.check : Icons.add,
            color: isInCart ? Colors.green : Colors.black,
          ),
          onTap: () {
            if (isInCart) {
              cart.removeItem(_items[index]['name']);
              // _deleteItem(_items[index]['name']);
            } else {
              cart.addItem(_items[index]['name']);
              // _addItem(_items[index]['name']);
            }
          },
        ),
      ),
    );
  }

  void _removeItem(int index, CartModel cart) {
    final removedItem = _items[index]['name'];
    final itemIndex = index; // Store index for undo

    setState(() {
      print("deleting: $removedItem");
      print("ITEMS (remove): $_items");
      cart.removeItem(removedItem);
      _deleteItem(removedItem); // Make sure _deleteItem removes from database
      _items.removeAt(index); // Remove the item from _items list
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$removedItem removed'),
        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.green,
          onPressed: () {
            setState(() {
              _items.insert(itemIndex, {'name': removedItem});
              _addItem(removedItem); // Re-add the item to the database
              cart.addItem(removedItem); // Add the item back to the cart
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // _clearItems();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _addCustomGroceryButton(),
              _showAddedButton(),
            ],
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return Consumer<CartModel>(
                  builder: (context, cart, child) {
                    final isInCart =
                        cart._items.contains(_items[index]['name']);
                    return Dismissible(
                      key: Key(_items[index]['name']),
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                      secondaryBackground: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (direction) {
                        _removeItem(index,
                            cart); // Removes item from database and screen
                      },
                      child: _individualIngredient(isInCart, index, cart),
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

class CartModel extends ChangeNotifier {
  final List<String> _items = [];
  final DatabaseHelper dbHelper = DatabaseHelper();

  CartModel() {
    _initializeCart();
  }

  List<String> get items => _items;

  void addItem(String item) {
    if (!_items.contains(item)) {
      _items.add(item);
      notifyListeners();
    }
  }

  void removeItem(String item) {
    if (_items.contains(item)) {
      _items.remove(item);
      notifyListeners();
    }
  }

  void _initializeCart() async {
    final data = await dbHelper.queryAllItems();
    _items.addAll(data.map((item) => item['name'] as String));
    notifyListeners();
  }
}
