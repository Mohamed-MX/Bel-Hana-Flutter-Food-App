import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../data/models/dish_model.dart';

/// Singleton SQLite helper for persisting favourite dishes
class FavoritesDatabaseHelper {
  static final FavoritesDatabaseHelper instance =
      FavoritesDatabaseHelper._internal();
  static Database? _db;

  FavoritesDatabaseHelper._internal();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'favorites.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE favorites (
            id TEXT PRIMARY KEY,
            arabicName TEXT NOT NULL,
            imageAsset TEXT NOT NULL,
            price REAL NOT NULL,
            category TEXT NOT NULL,
            categoryDisplayName TEXT NOT NULL,
            rating REAL NOT NULL DEFAULT 5.0,
            reviewCount INTEGER NOT NULL DEFAULT 100,
            description TEXT
          )
        ''');
      },
    );
  }

  /// Add a dish to favourites (idempotent)
  Future<void> addFavorite(Dish dish) async {
    final db = await database;
    await db.insert(
      'favorites',
      {
        'id': dish.id,
        'arabicName': dish.arabicName,
        'imageAsset': dish.imageAsset,
        'price': dish.price,
        'category': dish.category,
        'categoryDisplayName': dish.categoryDisplayName,
        'rating': dish.rating,
        'reviewCount': dish.reviewCount,
        'description': dish.description,
      },
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  /// Remove a dish from favourites by ID
  Future<void> removeFavorite(String id) async {
    final db = await database;
    await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }

  /// Check whether a dish is in favourites
  Future<bool> isFavorite(String id) async {
    final db = await database;
    final rows =
        await db.query('favorites', where: 'id = ?', whereArgs: [id]);
    return rows.isNotEmpty;
  }

  /// Load all favourited dishes
  Future<List<Dish>> getAllFavorites() async {
    final db = await database;
    final maps = await db.query('favorites');
    return maps.map((m) => _dishFromMap(m)).toList();
  }

  Dish _dishFromMap(Map<String, dynamic> m) {
    return Dish(
      id: m['id'] as String,
      name: m['arabicName'] as String, // name field = arabicName fallback
      arabicName: m['arabicName'] as String,
      imageAsset: m['imageAsset'] as String,
      price: (m['price'] as num).toDouble(),
      category: m['category'] as String,
      categoryDisplayName: m['categoryDisplayName'] as String,
      rating: (m['rating'] as num).toDouble(),
      reviewCount: m['reviewCount'] as int,
      description: m['description'] as String?,
    );
  }
}
