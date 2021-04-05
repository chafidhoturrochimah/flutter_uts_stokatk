class Kategori {

  int _idkategori;
  String _namakategori;

  int get idkategori => this._idkategori;
  set idkategori (int value) => this._idkategori = value;

  String get namakategori => this._namakategori;
  set namakategori (String value) => this._namakategori = value;

  // konstruktor versi 1 untuk mengeset nilai
  Kategori(
    this._namakategori
  );

  // konstruktor versi 2: konversi dari Map ke Item
  //untuk mengambil data dari sql yang tersimpan berbentuk Map
  //setelah itu akan disimpan kembali dalam bentuk variabel
  Kategori.fromMap(Map<String, dynamic> map) {
    this._idkategori = map['idkategori'];
    this._namakategori = map['namakategori'];
  }

  //membuat method Map untuk melakukan update dan insert.
  // konversi dari Item ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['idkategori'] = this._idkategori;
    map['namakategori'] = namakategori;
    return map;
  } 
}