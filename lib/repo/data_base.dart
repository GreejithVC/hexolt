import 'package:hexolt/models/post_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class DB {
  static final DB instance = DB._();
  static Database? _database;

  DB._();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = await getDatabasesPath();
    final String dbPath = join(path, 'hexolt.db');

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (Database db, int version) async {
        await _createPostsTable(db);
      },
    );
  }

  Future<int> getTableCount(String param) async {
    final db = await _initDatabase();
    // await dropTable(db);
    // await _createSurveyTable(db);
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM $param');
    if (result.isNotEmpty) {
      int count = result.first['count'] as int;
      print("get$param TableCount$count");
      return count;
    } else {
      return 0;
    }
  }

  Future<List<T>> getPaginatedDataList<T>({
    required String param,
    required T Function(Map<String, dynamic>) fromJson,
    int skip = 0,
  }) async {
    try {
      final Database db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        param,
        limit: 10,
        offset: skip,
      );
      debugPrint(
          "Database.retrieve $param List.length: ${maps.length.toString()} start from $skip");

      return maps.map(fromJson).toList();
    } catch (e) {
      debugPrint("Error while retrieving data: $e");
      return [];
    }
  }

  Future<void> addData({required String tableName, required Post data}) async {
    final Database db = await database;
    await db.insert(
      tableName,
      data.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    debugPrint("addData unique id: ${data.id}");
  }

  Future<void> dropTable() async {
    final db = await database;
    debugPrint("dropTable");
    await db.execute('DROP TABLE IF EXISTS posts');
    debugPrint("droppedTable");
    await deleteDatabase('hexolt.db');
    await _initDatabase();
  }

  Future<void> _createPostsTable(Database db) async {
    await db.execute('CREATE TABLE IF NOT EXISTS posts ('
        'id INTEGER PRIMARY KEY, '
        'title TEXT, '
        'body TEXT, '
        'userId TEXT'
        ')');
  }
}
