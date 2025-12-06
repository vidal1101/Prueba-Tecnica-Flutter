
import 'package:prueba_tecnica_flutter/data/datasources/local/local_db.dart';
import 'package:prueba_tecnica_flutter/domain/entities/local_image_entity.dart';
import 'package:sqflite/sqflite.dart';

class LocalImagesRepositoryImpl {
  final LocalDB db;

  LocalImagesRepositoryImpl(this.db);

  // Insertar imagen (evita duplicados)
  Future<bool> insertImage(LocalImageEntity image) async {
    final exists = await existsById(image.id);
    if (exists) return false;

    final dbClient = await db.database;
    await dbClient.insert(
      'saved_images',
      image.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
    return true;
  }

  // Verificar si ya existe
  Future<bool> existsById(String id) async {
    final dbClient = await db.database;
    final result = await dbClient.query(
      'saved_images',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return result.isNotEmpty;
  }

  // Traer todas
  Future<List<LocalImageEntity>> getAll() async {
    final dbClient = await db.database;
    final result = await dbClient.query('saved_images');
    return result.map((e) => LocalImageEntity.fromMap(e)).toList();
  }

  //getById
  Future<LocalImageEntity?> getById(String id) async {
    final dbClient = await db.database;
    final result = await dbClient.query(
      'saved_images',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return result.isNotEmpty ? LocalImageEntity.fromMap(result.first) : null;
  }

  // Actualizar
  Future<void> update(LocalImageEntity image) async {
    final dbClient = await db.database;

    await dbClient.update(
      'saved_images',
      image.toMap(),
      where: 'id = ?',
      whereArgs: [image.id],
    );
  }


  // Eliminar por ID
  Future<void> delete(String id) async {
    final dbClient = await db.database;
    await dbClient.delete(
      'saved_images',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
