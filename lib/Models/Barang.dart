class Barang {
  int _id;
  String _kodeBrg;
  int _idkategori;
  String _namaBrg;
  int _harga;
  int _stokAwal;
  int _inBrg;
  int _outBrg;
  int _stokAkhir;

  int get id => this._id;
  set id(int value) => this._id = value;

  String get kodeBrg => this._kodeBrg;
  set kodeBrg(String value) => this._kodeBrg = value;

  int get idkategori => this._idkategori;
  set idkategori(int value) => this._idkategori = value;

  String get namaBrg => this._namaBrg;
  set namaBrg(String value) => this._namaBrg = value;

  int get harga => this._harga;
  set harga(int value) => this._harga = value;

  int get stokAwal => this._stokAwal;
  set stokAwal(int value) => this._stokAwal = value;

  int get inBrg => this._inBrg;
  set inBrg(int value) => this._inBrg = value;

  int get outBrg => this._outBrg;
  set outBrg(int value) => this._outBrg = value;

  int get stokAkhir => this._stokAkhir;
  set stokAkhir(int value) => this._stokAkhir = value;

  // konstruktor versi 1 untuk mengeset nilai
  Barang(
    this._kodeBrg, 
    this._idkategori,
    this._namaBrg, 
    this._harga, 
    this._stokAwal, 
    this._inBrg, 
    this._outBrg, 
    this._stokAkhir
  );

  // konstruktor versi 2: konversi dari Map ke Item
  //untuk mengambil data dari sql yang tersimpan berbentuk Map
  //setelah itu akan disimpan kembali dalam bentuk variabel
  Barang.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._kodeBrg = map['kodeBrg'];
    this._idkategori = map['idkategori'];
    this._namaBrg = map['namaBrg'];
    this._harga = map['harga'];
    this._stokAwal = map['stokAwal'];
    this._inBrg = map['inBrg'];
    this._outBrg = map['outBrg'];
    this._stokAkhir = map['stokAkhir'];
  }

  //membuat method Map untuk melakukan update dan insert.
  // konversi dari Item ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['kodeBrg'] = kodeBrg;
    map['idkategori'] = idkategori;
    map['namaBrg'] = namaBrg;
    map['harga'] = harga;
    map['stokAwal'] = stokAwal;
    map['inBrg'] = inBrg;
    map['outBrg'] = outBrg;
    map['stokAkhir'] = stokAkhir;
    
    return map;
  } 
}