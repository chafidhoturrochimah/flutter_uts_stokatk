import 'package:flutter/material.dart';
import 'package:flutter_uts_stokatk/Helpers/DbHelper.dart';
import 'package:flutter_uts_stokatk/Models/Barang.dart';
import 'package:flutter_uts_stokatk/Models/Kategori.dart';
import 'package:sqflite/sqflite.dart';

class EntryFormBarang extends StatefulWidget {
  final Barang barang;

  EntryFormBarang(this.barang);

  @override
  EntryFormBarangState createState() => EntryFormBarangState(this.barang);
  
}

//class controller
class EntryFormBarangState extends State<EntryFormBarang> {
  Barang barang;

  EntryFormBarangState(this.barang);

  TextEditingController kodeBrgController = TextEditingController();
  TextEditingController idkategoriController = TextEditingController();
  TextEditingController namaBrgController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController stokAwalController = TextEditingController();
  TextEditingController inBrgController = TextEditingController();
  TextEditingController outBrgController = TextEditingController();
  TextEditingController stokAkhirController = TextEditingController();

  String dropdownkategori;
  DbHelper dbHelper = DbHelper();

  int count = 0;
  List<Kategori> itemList = [];

  void dropDownKategori() async {
    final Future<Database> dbFuture = dbHelper.initDb();

    dbFuture.then((database) {
      Future<List<Kategori>> itemListFuture = dbHelper.getKategoriList();
      itemListFuture.then((itemList) {
        setState(() {
          this.itemList = itemList;
          this.dropdownkategori = itemList[0].idkategori.toString();
          this.count = itemList.length;
        });
      });
    });
  }

  void initState() {
    super.initState();
    dropDownKategori();
  }

  @override
  Widget build(BuildContext context) {
    //kondisi
    if (barang != null) {
      kodeBrgController.text = barang.kodeBrg;
      idkategoriController.text = barang.idkategori.toString();
      namaBrgController.text = barang.namaBrg;
      hargaController.text = barang.harga.toString();
      stokAwalController.text = barang.stokAwal.toString();
      inBrgController.text = barang.inBrg.toString();
      outBrgController.text = barang.outBrg.toString();
      stokAkhirController.text = barang.stokAkhir.toString();
    }

    //rubah
    return Scaffold(
      appBar: AppBar(
        title: barang == null ? 
        Text(
          'Tambah Barang',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'CandaraBold',
          ),
        ) 
        : 
        Text(
          'Ubah Barang',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'CandaraBold',
          ),
        ),
        leading: Container(
          child: new IconButton(
            icon: new Icon(Icons.keyboard_arrow_left,), 
            onPressed: (){
              Navigator.pop(context, '/barang');
            },
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff0096ff), Color(0xff6610f2)],
              begin: FractionalOffset.bottomLeft,
              end: FractionalOffset.topRight
            )
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            // kode barang
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: kodeBrgController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Kode Barang',
                  labelStyle: TextStyle(
                    fontFamily: 'Candara',
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {
                  //
                },
              ),
            ),

            // idkategori 
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: DropdownButton<String>(
                isExpanded: true,
                value: dropdownkategori,
                items: itemList.map((value) {
                  return new DropdownMenuItem<String>(
                    value: value.idkategori.toString(),
                    child: new Text(
                      value.namakategori,
                      style: TextStyle(
                        fontFamily: 'Candara'
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (selectedItem) => setState(() {
                  dropdownkategori = selectedItem;
                }),
              ),
            ),

            // nama barang
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: namaBrgController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Nama Barang',
                  labelStyle: TextStyle(
                    fontFamily: 'Candara',
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {
                  //
                },
              ),
            ),

            // harga barang
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: hargaController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Harga',
                  labelStyle: TextStyle(
                    fontFamily: 'Candara',
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {
                  //
                },
              ),
            ),

            // stok awal
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: stokAwalController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Stok Awal',
                  labelStyle: TextStyle(
                    fontFamily: 'Candara',
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {
                  //
                },
              ),
            ),

            // in barang / barang masuk
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: inBrgController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Barang Masuk',
                  labelStyle: TextStyle(
                    fontFamily: 'Candara',
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {
                  //
                },
              ),
            ),

            // out barang / barang keluar
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: outBrgController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Barang Keluar',
                  labelStyle: TextStyle(
                    fontFamily: 'Candara',
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {
                  //
                },
              ),
            ),

            // stok akhir
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: stokAkhirController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Stok Akhir',
                  labelStyle: TextStyle(
                    fontFamily: 'Candara',
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {
                  //
                },
              ),
            ),

            // tombol button
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Row(
                children: <Widget>[
                  // tombol simpan
                  Expanded(
                    // ignore: deprecated_member_use
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        gradient: LinearGradient(
                          // Where the linear gradient begins and ends
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          // Add one stop for each color. Stops should increase from 0 to 1
                          stops: [0.1, 0.9],
                          colors: [
                            // Colors are easy thanks to Flutter's Colors class.
                            Color(0xff0096ff),
                            Color(0xff6610f2),
                          ],
                        ),
                      ),
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        child: Text(
                          'Save',
                          style: TextStyle(
                            fontFamily: 'CandaraBold',
                            color: Colors.white,
                          ),
                          textScaleFactor: 1.5,
                        ),
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60.0)
                        ),
                        onPressed: () {
                          if (barang == null) {
                            // tambah data
                            barang = Barang(
                              kodeBrgController.text,
                              int.parse(dropdownkategori),
                              namaBrgController.text,
                              int.parse(hargaController.text),
                              int.parse(stokAwalController.text),
                              int.parse(inBrgController.text),
                              int.parse(outBrgController.text),
                              int.parse(stokAkhirController.text)
                            );
                          } else {
                            // ubah data
                            barang.kodeBrg = kodeBrgController.text;
                            barang.idkategori = int.parse(dropdownkategori);
                            barang.namaBrg = namaBrgController.text;
                            barang.harga = int.parse(hargaController.text);
                            barang.stokAwal = int.parse(stokAwalController.text);
                            barang.inBrg = int.parse(inBrgController.text);
                            barang.outBrg = int.parse(outBrgController.text);
                            barang.stokAkhir = int.parse(stokAkhirController.text);
                          }
                          // kembali ke layar sebelumnya dengan membawa objek item
                          Navigator.pop(context, barang);
                        },
                      ),
                    ),
                  ),

                  Container(
                    width: 5.0,
                  ),

                  // tombol batal
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        gradient: LinearGradient(
                          // Where the linear gradient begins and ends
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          // Add one stop for each color. Stops should increase from 0 to 1
                          stops: [0.1, 0.9],
                          colors: [
                            // Colors are easy thanks to Flutter's Colors class.
                            Color(0xff0096ff),
                            Color(0xff6610f2),
                          ],
                        ),
                      ),
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontFamily: 'CandaraBold',
                            color: Colors.white,
                          ),
                          textScaleFactor: 1.5,
                        ),
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60.0)
                        ),
                        onPressed: () {
                          Navigator.pop(context, '/barang');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
