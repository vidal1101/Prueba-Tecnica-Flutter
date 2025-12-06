import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class LocalDB {
  static final LocalDB instance = LocalDB._init();
  static Database? _database;

  LocalDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final docs = await getApplicationDocumentsDirectory();
    final path = join(docs.path, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE preferences (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          customName TEXT,
          imageUrl TEXT
        )
      ''');
      },
    );
  }

  Future<List<Map<String, dynamic>>> getAllPrefs() async {
    final db = await instance.database;
    return db.query('preferences');
  }

  Future<int> insertPref(Map<String, dynamic> pref) async {
    final db = await instance.database;
    return db.insert('preferences', pref);
  }

  Future<int> updatePref(Map<String, dynamic> pref) async {
    final db = await instance.database;
    return db.update(
      'preferences',
      pref,
      where: 'id = ?',
      whereArgs: [pref['id']],
    );
  }

  Future<int> deletePref(int id) async {
    final db = await instance.database;
    return db.delete(
      'preferences',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
