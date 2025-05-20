import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'virtual_animal.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE animals(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        type TEXT,
        health REAL,
        happiness REAL,
        hunger REAL,
        lastUpdateTime TEXT
      )
    ''');
  }

  Future<int> insertAnimal(Map<String, dynamic> animal) async {
    Database db = await database;
    return await db.insert('animals', animal);
  }

  Future<List<Map<String, dynamic>>> getAnimals() async {
    Database db = await database;
    return await db.query('animals');
  }

  Future<int> updateAnimal(Map<String, dynamic> animal) async {
    Database db = await database;
    return await db.update(
      'animals',
      animal,
      where: 'id = ?',
      whereArgs: [animal['id']],
    );
  }

  Future<int> deleteAnimal(int id) async {
    Database db = await database;
    return await db.delete(
      'animals',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
} 