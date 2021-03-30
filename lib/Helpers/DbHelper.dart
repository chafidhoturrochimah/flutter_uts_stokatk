import 'package:flutter_uts_stokatk/Models/Barang.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DbHelper {

  static DbHelper _dbHelper;
  static Database _database;
  DbHelper._createObject();

  Future<Database> initDb() async {

    //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'stokatk.db';

    //create, read databases
    var stokatDatabase = openDatabase(
      path, version: 8, 
      onCreate: _createDb,
      onUpgrade: _onUpgrade
    );

    //mengembalikan nilai object sebagai hasil dari fungsinya
    return stokatDatabase;
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    _createDb(db, newVersion);
  }

  //buat tabel baru dengan nama item
  void _createDb(Database db, int version) async {
    await db.execute
    ('''
      CREATE TABLE barang 
      (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        kodeBrg TEXT,
        namaBrg TEXT,
        satuan TEXT,
        stokAwal INTEGER,
        inBrg INTEGER,
        outBrg INTEGER,
        stokAkhir INTEGER
      )
    ''');
  }

  //select databases
  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.initDb();
    var mapList = await db.query(
      'barang', 
      orderBy: 'kodeBrg'
    );
    return mapList;
  }

  //create databases
  Future<int> insert(Barang object) async {
    Database db = await this.initDb();
    int count = await db.insert(
      'barang', 
      object.toMap()
    );
    return count;
  }

  //update databases
  Future<int> update(Barang object) async {
    Database db = await this.initDb();
    int count = await db.update(
      'barang', 
      object.toMap(), 
      where: 'id=?', 
      whereArgs: [object.id]
    );
    return count;
  }

  //delete databases
  Future<int> delete(Barang object) async {
    Database db = await this.initDb();
    int count = await db.delete(
      'barang', 
      where: 'id=?', 
      whereArgs: [object.id]
    );
    return count;
  }

  Future<List<Barang>> getBarangList() async {
    var barangMapList = await select();
    int count = barangMapList.length;
    List<Barang> itemList = List<Barang>();
    for (int i = 0; i < count; i++) {
      itemList.add(
        Barang.fromMap(
          barangMapList[i]
        )
      );
    }
    return itemList;
  }

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }
}
