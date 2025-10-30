import 'dart:convert';

import 'package:flutter_project_1/data/models/user.dart';
import 'package:sqflite/sqflite.dart';

class RecipesAppSqliteDb {
  // Users table ( id - name - email - password - bookmarksIds)

  static late Database _database;

  static String dbPath = 'recipes_app.db';
  static String tableName = 'users';
  static String columnId = 'id';
  static String columnName = 'name';
  static String columnEmail = 'email';
  static String columnPassword = 'password';
  static String columnBookmarksIds = 'bookmarksIds';

  static Future<void> init() async {
    _database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        // where you creat tables (one time only)
        db.execute(
          //todo: add bookmarks
          'CREATE TABLE $tableName ($columnId INTEGER PRIMARY KEY, $columnName TEXT, $columnEmail TEXT, $columnPassword TEXT, $columnBookmarksIds TEXT)',
        );
      },
      onOpen: (db) {
        // read existing data
      },
    );
  }

  static Future<int> signupUser(User user) async {
    int id =  await _database.insert(
    tableName,
    {
      columnName: user.name,
      columnEmail: user.email,
      columnPassword: user.password,
      columnBookmarksIds: jsonEncode(user.bookmarksIds),
    },
  );
    return id;
  }

  static Future<User> loginUser(String email, String password) async {
    final result = await _database.query(
      tableName,
      where: '$columnEmail = ? AND $columnPassword = ?',
      whereArgs: [email, password],
    );

    if (result.isEmpty) throw Exception('Email or password is incorrect');

    // Convert bookmarks JSON string back to List<int> before creating User
    final row = Map<String, dynamic>.from(result[0]);
    try {
      final bookmarksJson = row[columnBookmarksIds];
      if (bookmarksJson is String) {
        final decoded = jsonDecode(bookmarksJson);
        row[columnBookmarksIds] = List<int>.from(decoded.map((e) => e as int));
      }
    } catch (_) {
      row[columnBookmarksIds] = <int>[];
    }

    User user = User.fromJson(row);
    return user;
  }

  static Future<void> updateUserBookmarksInDb(int userId, List<int> bookmarksIds) async {
    await _database.update(
      tableName,
      {
        columnBookmarksIds: jsonEncode(bookmarksIds),
      },
      where: '$columnId = ?',
      whereArgs: [userId],
    );
  }
}
