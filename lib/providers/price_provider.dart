import 'dart:async';

import 'package:flutter_application_1/model/price_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'prices.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE prices(id TEXT PRIMARY KEY, name TEXT, price REAL)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertPrice(PriceModel price) async {
    final db = await database;
    await db.insert('prices', price.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<PriceModel>> getPrices() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('prices');
    return List.generate(maps.length, (i) {
      return PriceModel(
        id: maps[i]['id'],
        name: maps[i]['name'],
        price: maps[i]['price'],
      );
    });
  }
}
