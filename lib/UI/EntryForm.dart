import 'package:flutter/material.dart';
import 'package:flutter_uts_stokatk/Models/Barang.dart';

class EntryForm extends StatefulWidget {
  final Barang barang;

  EntryForm(this.barang);

  @override
  EntryFormState createState() => EntryFormState(this.barang);
}

//class controller
class EntryFormState extends State<EntryForm> {
  Barang barang;

  EntryFormState(this.barang);

  TextEditingController kodeBrgController = TextEditingController();
  TextEditingController namaBrgController = TextEditingController();
  TextEditingController satuanController = TextEditingController();
  TextEditingController stokAwalController = TextEditingController();
  TextEditingController inBrgController = TextEditingController();
  TextEditingController outBrgController = TextEditingController();
  TextEditingController stokAkhirController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //kondisi
    if (barang != null) {
      kodeBrgController.text = barang.kodeBrg;
      namaBrgController.text = barang.namaBrg;
      satuanController.text = barang.satuan;
      stokAwalController.text = barang.stokAwal.toString();
      inBrgController.text = barang.inBrg.toString();
      outBrgController.text = barang.outBrg.toString();
      stokAkhirController.text = barang.stokAkhir.toString();
    }

    //rubah
    return Scaffold(
      appBar: AppBar(
        title: barang == null ? Text('Tambah') : Text('Ubah'),
        leading: Container(
          child: new IconButton(
            icon: new Icon(Icons.keyboard_arrow_left,), 
            onPressed: (){
              Navigator.pop(context);
            },
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {
                  //
                },
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {
                  //
                },
              ),
            ),

            // satuan barang
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: satuanController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Satuan',
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
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Save',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        if (barang == null) {
                          // tambah data
                          barang = Barang(
                            kodeBrgController.text,
                            namaBrgController.text,
                            satuanController.text,
                            int.parse(stokAwalController.text),
                            int.parse(inBrgController.text),
                            int.parse(outBrgController.text),
                            int.parse(stokAkhirController.text)
                          );
                        } else {
                          // ubah data
                          barang.kodeBrg = kodeBrgController.text;
                          barang.namaBrg = namaBrgController.text;
                          barang.satuan = satuanController.text;
                          barang.stokAwal = int.parse(stokAwalController.text);
                          barang.stokAwal = int.parse(inBrgController.text);
                          barang.stokAwal = int.parse(outBrgController.text);
                          barang.stokAwal = int.parse(stokAkhirController.text);
                        }
                        // kembali ke layar sebelumnya dengan membawa objek item
                        Navigator.pop(context, barang);
                      },
                    ),
                  ),

                  Container(
                    width: 5.0,
                  ),

                  // tombol batal
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Cancel',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
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
