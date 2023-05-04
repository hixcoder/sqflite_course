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
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 4, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print("onUpgrade ========================");
    await db.execute(''' 
    ALTER TABLE notes ADD COLUMN color TEXT
    ''');
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE "notes"(
      "id" INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,
      "title" TEXT NOT NULL,
      "note" TEXT NOT NULL,
      "color" TEXT NOT NULL
    )
    ''');
    print("onCreate ========================");
  }

// SLECT
  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

// INSERT
  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

// UPDATE
  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

// DELETE
  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

// DELETE DATABASE
  myDeleteDataBase() async {
    String dataBasePath = await getDatabasesPath();
    String path = dataBasePath + "/note.db";
    await deleteDatabase(path);
  }
}
