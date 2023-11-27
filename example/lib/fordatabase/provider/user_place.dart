import 'dart:io';
import 'package:Accelerite_PlugIn_Example/fordatabase/modal/newplace.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;

import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_plagine(id TEXT PRIMARY KEY,title TEXT,image TEXT)');
    },
    version: 1,
  );
  return db;
}

class UesrPlaceNotifier extends StateNotifier<List<Place>> {
  UesrPlaceNotifier() : super(const []);
  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query('user_plagine');
    final places = data
        .map((row) => Place(
              id: row['id'] as String,
              title: row['title'] as String,
              image: File(row['image'] as String),
            ))
        .toList();
    state = places;
  }

  void addplace(
    String title,
    File image,
  ) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$filename');
    final newplace = Place(
      title: title,
      image: copiedImage,
    );
    final db = await _getDatabase();

    db.insert('user_plagine', {
      'id': newplace.id,
      'title': newplace.title,
      'image': newplace.image.path,
    });
    state = [newplace, ...state];
  }
}

final userplaceprovider = StateNotifierProvider<UesrPlaceNotifier, List<Place>>(
    (ref) => UesrPlaceNotifier());
