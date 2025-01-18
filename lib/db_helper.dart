import 'dart:io' as io;
import 'cart_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'apple.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate,);
    return db;
  }

  // Create Table cart
  _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE cart ('
        'id INTEGER PRIMARY KEY,'
        'productId VARCHAR UNIQUE,'
        'productName TEXT,'
        'productPrice INTEGER,'
        'productAmount INTEGER,'
        'qty INTEGER, '
        'unitTag TEXT, '
        'image TEXT)');
  }

  // Get Data From Table cart
  Future<List<Cart>> getCartList() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query('cart');
    return queryResult.map((e) => Cart.fromMap(e)).toList();
  }

  // Insert Data Into Table cart
  Future<Cart> insert(Cart cart) async {
    // print (cart.toMap());
    var dbClient = await db;
    await dbClient!.insert('cart', cart.toMap());
    return cart;
  }

  // Update Data Into Table cart for selected Record-Id
  Future<int> updateQty(Cart cart) async {
    var dbClient = await db;
    int result = await dbClient!.update('cart', cart.toMap(), where: 'id = ?', whereArgs: [cart.id]);
    return result; // Return the number of rows deleted
  }

  // Delete Data Into Table cart for selected Record-Id
  Future<int> delete(int id) async {
    var dbClient = await db;
    int result = await dbClient!.delete('cart', where: 'id = ?', whereArgs: [id]);
    return result; // Return the number of rows deleted
  }


}
