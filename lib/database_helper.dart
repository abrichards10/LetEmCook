import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'example.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE items(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)',
    );
  }

  Future<void> insertItem(Map<String, dynamic> row) async {
    final db = await database;
    await db.insert('items', row);
  }

  Future<List<Map<String, dynamic>>> queryAllItems() async {
    final db = await database;
    return await db.query('items');
  }

  Future<int> updateItem(Map<String, dynamic> row) async {
    Database db = await database;
    int id = row['id'];
    return await db.update('items', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteItem(String id) async {
    Database db = await database;
    return await db.delete('items', where: 'name = ?', whereArgs: [id]);
  }

  Future<int> deleteAllItems() async {
    Database db = await database;
    return await db.delete('items');
  }
}
