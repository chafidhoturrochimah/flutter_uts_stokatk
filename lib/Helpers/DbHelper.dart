import 'package:flutter_uts_stokatk/Models/Barang.dart';
import 'package:flutter_uts_stokatk/Models/Kategori.dart';
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
    String path = directory.path + 'item.db';

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
    var batch = db.batch();

    await batch.execute('DROP TABLE IF EXISTS barang');
    await batch.execute('DROP TABLE IF EXISTS kategori');
    await batch.execute
    ('''
      CREATE TABLE barang 
      (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        kodeBrg TEXT,
        idkategori INTEGER,
        namaBrg TEXT,
        harga INTEGER,
        stokAwal INTEGER,
        inBrg INTEGER,
        outBrg INTEGER,
        stokAkhir INTEGER
      )
    ''');
    await batch.execute
    ('''
      CREATE TABLE kategori 
      (
        idkategori INTEGER PRIMARY KEY AUTOINCREMENT,
        namakategori TEXT
      )
    ''');
    await batch.commit();
  }

  //select databases
  Future<List<Map<String, dynamic>>> selectBarang() async {
    Database db = await this.initDb();
    //List<Map> list = await db.rawQuery('SELECT * FROM barang');
    var mapList = await db.query(
      'barang', 
      orderBy: 'kodeBrg'
    );
    return mapList;
  }
  
  //create databases
  Future<int> insertBarang(Barang object) async {
    Database db = await this.initDb();
    int count = await db.insert(
      'barang', 
      object.toMap(),
    );
    return count;
  }

  //update databases
  Future<int> updateBarang(Barang object) async {
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
  Future<int> deleteBarang(Barang object) async {
    Database db = await this.initDb();
    int count = await db.delete(
      'barang',  
      where: 'id=?', 
      whereArgs: [object.id]
    );
    return count;
  }

  Future<List<Barang>> getItemList() async {
    var itemMapList = await selectBarang();
    int count = itemMapList.length;
    // ignore: deprecated_member_use
    List<Barang> itemList = List<Barang>();
    for (int i = 0; i < count; i++) {
      itemList.add(
        Barang.fromMap(
          itemMapList[i]
        )
      );
    }
    return itemList;
  }

  //----------Kategori-------------\\
  //select databases
  Future<List<Map<String, dynamic>>> selectKategori() async {
    Database db = await this.initDb();
    //List<Map> list = await db.rawQuery('SELECT * FROM kategori');
    var mapList = await db.query(
      'kategori', 
      orderBy: 'idkategori'
    );
    return mapList;
  }
  
  //create databases
  Future<int> insertKategori(Kategori object) async {
    Database db = await this.initDb();
    int count = await db.insert(
      'kategori', 
      object.toMap(),
    );
    return count;
  }

  //update databases
  Future<int> updateKategori(Kategori object) async {
    Database db = await this.initDb();
    int count = await db.update(
      'kategori', 
      object.toMap(), 
      where: 'idkategori=?', 
      whereArgs: [object.idkategori]
    );
    return count;
  }

  //delete databases
  Future<int> deleteKategori(Kategori object) async {
    Database db = await this.initDb();
    int count = 
    await db.delete(
      'kategori', 
      where: 'idkategori=?',  
      whereArgs: [object.idkategori]
    );
    //untuk menghapsus idkategori yang ada di list view home barang
    await db.delete(
      'barang', 
      where: 'idkategori=?',  
      whereArgs: [object.idkategori]
    );
    return count;
  }

  Future<List<Kategori>> getKategoriList() async {
    var itemMapList = await selectKategori();
    int count = itemMapList.length;
    // ignore: deprecated_member_use
    List<Kategori> itemList = List<Kategori>();
    for (int i = 0; i < count; i++) {
      itemList.add(
        Kategori.fromMap(
          itemMapList[i]
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
