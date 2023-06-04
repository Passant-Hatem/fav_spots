import 'dart:io';

import 'package:fav_spots/models/spot.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

import '../models/spot_location.dart';

//TODO split database logic from provider
Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'spots.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_spots(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)');
    },
    version: 1,
  );
  return db;
}


class UserSpotsNotifier extends StateNotifier<List<Spot>> {
  UserSpotsNotifier() : super(const []);

  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query('user_spots');
    final places = data
        .map(
          (row) => Spot(
            id: row['id'] as String,
            title: row['title'] as String,
            image: File(row['image'] as String),
            location: SpotLocation(
              latitude: row['lat'] as double,
              longitude: row['lng'] as double,
              address: row['address'] as String,
            ),
          ),
        )
        .toList();

    state = places;
  }


  void addSpot(String title, File image, SpotLocation spotLocation) async {
  final appDir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$filename');

    final newSpot =
        Spot(title: title, image: copiedImage, location: spotLocation);

    final db = await _getDatabase();
    db.insert('user_spots', {
      'id': newSpot.id,
      'title': newSpot.title,
      'image': newSpot.image.path,
      'lat': newSpot.location.latitude,
      'lng': newSpot.location.longitude,
      'address': newSpot.location.address,
    });
    state = [newSpot, ...state];
  }
}

final userSpotsProvider = StateNotifierProvider<UserSpotsNotifier, List<Spot>>(
  (ref) => UserSpotsNotifier(),
);
