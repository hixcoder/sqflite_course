import 'package:sqflite/sqflite.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String dataBasePath = await getDatabasesPath();
    String path = dataBasePath + "/note.db";
    Database mydb = await openDatabase(path, onCreate: _onCreate);
    return mydb;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
CREATE TABLE "notes"(
  id INTEGER AUTOINCREMENT NOT NULL PRIMARY KEY,
  notes TEXT NOT NULL
)
''');
    print("==> create database and table.");
  }
}
