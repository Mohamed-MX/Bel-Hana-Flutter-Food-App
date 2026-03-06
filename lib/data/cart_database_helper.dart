import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../presentation/cart/cart_item_model.dart';

/// Singleton SQLite helper for persisting cart items
class CartDatabaseHelper {
  static final CartDatabaseHelper instance = CartDatabaseHelper._internal();
  static Database? _db;

  CartDatabaseHelper._internal();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'cart.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE cart_items (
            id TEXT PRIMARY KEY,
            arabicName TEXT NOT NULL,
            imageAsset TEXT NOT NULL,
            price REAL NOT NULL,
            quantity INTEGER NOT NULL DEFAULT 1
          )
        ''');
      },
    );
  }

  /// Insert item or increment quantity if it already exists
  Future<void> insertOrIncrement(CartItemModel item) async {
    final db = await database;
    final existing = await db.query(
      'cart_items',
      where: 'id = ?',
      whereArgs: [item.dishId],
    );
    if (existing.isEmpty) {
      await db.insert('cart_items', item.toMap());
    } else {
      final currentQty = existing.first['quantity'] as int;
      await db.update(
        'cart_items',
        {'quantity': currentQty + 1},
        where: 'id = ?',
        whereArgs: [item.dishId],
      );
    }
  }
  /// Set exact quantity for an item (removes it if qty <= 0)
  Future<void> updateQuantity(String dishId, int quantity) async {
    final db = await database;
    if (quantity <= 0) {
      await db.delete('cart_items', where: 'id = ?', whereArgs: [dishId]);
    } else {
      await db.update(
        'cart_items',
        {'quantity': quantity},
        where: 'id = ?',
        whereArgs: [dishId],
      );
    }
  }

  /// Remove a single item entirely
  Future<void> deleteItem(String dishId) async {
    final db = await database;
    await db.delete('cart_items', where: 'id = ?', whereArgs: [dishId]);
  }

  /// Delete all cart items
  Future<void> clearCart() async {
    final db = await database;
    await db.delete('cart_items');
  }

  /// Load all cart items
  Future<List<CartItemModel>> getAllItems() async {
    final db = await database;
    final maps = await db.query('cart_items');
    return maps.map((m) => CartItemModel.fromMap(m)).toList();
  }
}
