import 'dart:async';
import 'package:flutter/material.dart';
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

    debugPrint(" Database path: $path");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        debugPrint("Creating local database...");

        await db.execute('''
        CREATE TABLE preferences (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          customName TEXT,
          imageUrl TEXT
        );
      ''');

        await db.execute('''
        CREATE TABLE saved_images (
          id TEXT PRIMARY KEY,
          author TEXT,
          download_url TEXT
        );
      ''');

        debugPrint("Database structure created successfully!");
      },
      onOpen: (db) async {
        // Ejecutar migraciones necesarias (añadir columnas que falten)
        await _ensureColumnExists(db, 'saved_images', 'custom_name', 'TEXT');
      },
    );
  }

  Future<void> _ensureColumnExists(
      Database db, String table, String column, String columnType) async {
    try {
      final info = await db.rawQuery('PRAGMA table_info($table);');
      final exists = info.any((row) => row['name'] == column);
      if (!exists) {
        debugPrint(" Adding missing column '$column' to table '$table'");
        await db.execute('ALTER TABLE $table ADD COLUMN $column $columnType;');
        debugPrint("Column '$column' added");
      }
    } catch (e) {
      debugPrint("❌ Error ensuring column exists: $e");
    }
  }

  // ==============================
//  PREFERENCES CRUD
// ==============================

  Future<List<Map<String, dynamic>>> getAllPrefs() async {
    final db = await instance.database;
    try {
      return await db.query('preferences');
    } catch (e) {
      debugPrint("❌ Error getting preferences: $e");
      return [];
    }
  }

  Future<int> insertPref(Map<String, dynamic> pref) async {
    final db = await instance.database;
    try {
      return await db.insert('preferences', pref);
    } catch (e) {
      debugPrint("❌ Error inserting into preferences: $e");
      return -1;
    }
  }

  Future<int> updatePref(Map<String, dynamic> pref) async {
    final db = await instance.database;
    try {
      return await db.update(
        'preferences',
        pref,
        where: 'id = ?',
        whereArgs: [pref['id']],
      );
    } catch (e) {
      debugPrint("❌ Error updating preferences: $e");
      return -1;
    }
  }

  Future<int> deletePref(int id) async {
    final db = await instance.database;
    try {
      return await db.delete(
        'preferences',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      debugPrint("❌ Error deleting from preferences: $e");
      return -1;
    }
  }

  Future<List<Map<String, dynamic>>> getAllImages() async {
    final db = await instance.database;
    try {
      return await db.query('saved_images');
    } catch (e) {
      debugPrint("❌ Error getting saved_images: $e");
      return [];
    }
  }

  Future<bool> insertImage(Map<String, dynamic> image) async {
    final db = await instance.database;
    try {
      final res = await db.query(
        'saved_images',
        where: 'id = ?',
        whereArgs: [image['id']],
        limit: 1,
      );
      if (res.isNotEmpty) return false;

      // Asegurarse de que el map tenga las claves que queremos (no obligatorio)
      final row = {
        'id': image['id'],
        'author': image['author'],
        'download_url': image['download_url'],
        'custom_name': image['custom_name'], 
      };
      await db.insert('saved_images', row);
      return true;
    } catch (e) {
      debugPrint(" Error inserting image: $e");
      return false;
    }
  }

  Future<int> deleteImage(String id) async {
    final db = await instance.database;
    try {
      return await db.delete(
        'saved_images',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      debugPrint(" Error deleting image: $e");
      return -1;
    }
  }

  Future<Map<String, dynamic>?> getImageById(String id) async {
    final db = await instance.database;
    try {
      final res = await db.query(
        'saved_images',
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      );
      return res.isNotEmpty ? res.first : null;
    } catch (e) {
      debugPrint(" Error getting image by ID: $e");
      return null;
    }
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
