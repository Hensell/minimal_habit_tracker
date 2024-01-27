import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

class DatabaseProvider {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();

    return _database!;
  }

  static Future _initDatabase() async {
    final DatabaseFactory dbFactory =
        kIsWeb ? databaseFactoryWeb : databaseFactoryIo;

    String dbPath = "";
    const String dbName = "habit_database.db";

    if (!kIsWeb) {
      if (Platform.isAndroid) {
        final docsDir = await getApplicationDocumentsDirectory();
        dbPath = "${docsDir.path}$dbName";
      } else {
        dbPath = dbName;
      }
    } else {
      dbPath = dbName;
    }

    final db = await dbFactory.openDatabase(dbPath);
    return db;
  }
}
