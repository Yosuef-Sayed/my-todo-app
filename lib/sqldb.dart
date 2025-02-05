import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:developer';

class SqlDB {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDatabase();
      return _db;
    } else {
      return _db;
    }
  }

  initDatabase() async {
    String dbpath = await getDatabasesPath();
    String path = join(dbpath, "database.db");
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) {
    log("onUpgrade - SQLite");
  }

  _onCreate(Database db, int version) async {
    await db.execute(""); // Enter Your Query
    log("OnCreate - SQLite");
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  deleteMyDatabase() async {
    String dbpath = await getDatabasesPath();
    String path = join(dbpath, "note_it.db");
    await deleteDatabase(path);
    log("onDelete - SQLite");
  }

  printDatabaseTables() async {
    try {
      Database? mydb = await db;
      List<Map<String, dynamic>> tables = await mydb!
          .rawQuery("SELECT name FROM sqlite_master WHERE type='table'");
      print("Tables in the database:");
      for (var table in tables) {
        print(table['name']);
      }
    } catch (e) {
      print("Error retrieving tables: $e");
    }
  }

  // =========================================================================
/*
  read(String table) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.query(table);
    return response;
  }

  insert(String table, Map<String, Object?> values) async {
    Database? mydb = await db;
    int response = await mydb!.insert(table, values);
    return response;
  }

  update(String table, Map<String, Object?> values, where) async {
    Database? mydb = await db;
    int response = await mydb!.update(table, values, where: where);
    return response;
  }

  delete(String table, where) async {
    Database? mydb = await db;
    int response = await mydb!.delete(table, where: where);
    return response;
  }
*/
}
