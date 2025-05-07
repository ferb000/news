import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'dart:async';
import '../models/item_model.dart';
import './repository_provider.dart';

class NewsDbProvider implements Source, Cache {
  late Database db;

  NewsDbProvider() {
    init();
  }
  @override
  Future<List<int>> fetchTopIds() async {
    return [];
  }

  void init() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, "items.db");

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute("""
      CREATE TABLE Items
        (
        id INTEGER PRIMARY KEY,
        type TEXT,
        by TEXT,
        time INTGER,
        text TEXT,
        parent INTEGER,
        kids BLOB, 
        dead INTEGER,
        deleted INTEGER,
        url TEXT,
        score INTEGER,
        title TEXT,
        descendants INTEGER
        )
      """);
      },
    );
  }

  Future<ItemModel?> fetchItems(int id) async {
    final maps = await db.query(
      "Items",
      columns: null /* ["title",add more columns]*/,
      where: "id = ?",
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ItemModel.fromDb(maps.first);
    }
    return null;
  }

  @override
  Future<int> addItems(ItemModel item) {
    return db.insert(
      "Items",
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> clearTable() async {
    return await db.delete('Items');
  }
}

final newsDbProvider = NewsDbProvider();
