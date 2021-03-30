class Barang {
  int _id;
  String _kodeBrg;
  String _namaBrg;
  String _satuan;
  int _stokAwal;
  int _inBrg;
  int _outBrg;
  int _stokAkhir;

  int get id => this._id;
  set id(int value) => this._id = value;

  get kodeBrg => this._kodeBrg;
  set kodeBrg( value) => this._kodeBrg = value;

  get namaBrg => this._namaBrg;
  set namaBrg( value) => this._namaBrg = value;

  get satuan => this._satuan;
  set satuan( value) => this._satuan = value;

  get stokAwal => this._stokAwal;
  set stokAwal( value) => this._stokAwal = value;

  get inBrg => this._inBrg;
  set inBrg( value) => this._inBrg = value;

  get outBrg => this._outBrg;
  set outBrg( value) => this._outBrg = value;

  get stokAkhir => this._stokAkhir;
  set stokAkhir( value) => this._stokAkhir = value;

  // konstruktor versi 1 untuk mengeset nilai
  Barang(
    this._kodeBrg, 
    this._namaBrg, 
    this._satuan, 
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
    this._namaBrg = map['namaBrg'];
    this._satuan = map['satuan'];
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
    map['namaBrg'] = namaBrg;
    map['satuan'] = satuan;
    map['stokAwal'] = stokAwal;
    map['inBrg'] = inBrg;
    map['outBrg'] = outBrg;
    map['stokAkhir'] = stokAkhir;
    
    return map;
  } 
}