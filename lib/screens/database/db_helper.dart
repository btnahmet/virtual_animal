import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:virtual_animal/screens/animals/animal_model.dart';

class DBHelper {
  static Database? _database;

  // Veritabanı bağlantısını başlatıyoruz
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  // Veritabanını başlatma
  Future _initDatabase() async {
    String path = join(await getDatabasesPath(), 'animal_db.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  // Veritabanı oluşturma
  Future _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE animals(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        health REAL,
        happiness REAL,
        hunger REAL
      )
    ''');
  }

  // Hayvan verisini ekleme
  Future<int> insertAnimal(AnimalModel animal) async {
    final db = await database;
    return await db.insert('animals', animal.toMap());
  }

  // Hayvan verisini okuma
  Future<List<AnimalModel>> getAnimals() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('animals');

    return List.generate(maps.length, (i) {
      return AnimalModel.fromMap(maps[i]);
    });
  }

  // Hayvan verisini güncelleme
  Future<int> updateAnimal(AnimalModel animal) async {
    final db = await database;
    return await db.update(
      'animals',
      animal.toMap(),
      where: 'id = ?',
      whereArgs: [animal.id],
    );
  }

  // Hayvan verisini silme
  Future<int> deleteAnimal(int id) async {
    final db = await database;
    return await db.delete(
      'animals',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
