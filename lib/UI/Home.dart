import 'package:flutter/material.dart';
import 'package:flutter_uts_stokatk/Helpers/DbHelper.dart';
import 'package:flutter_uts_stokatk/Models/Barang.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

import 'EntryForm.dart';

//pendukung program asinkron
class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  DbHelper dbHelper = DbHelper();

  int count = 0;
  
  List<Barang> itemList;

  @override
  Widget build(BuildContext context) {
    updateListView();
    if (itemList == null) {
      // ignore: deprecated_member_use
      itemList = List<Barang>();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Stok Barang'),
      ),

      body: Column(children: [
        Expanded(
          child: createListView(),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: double.infinity,
            // ignore: deprecated_member_use
            child: RaisedButton(
              child: Text("Tambah Barang"),
              onPressed: () async {
                var item = await navigateToEntryForm(context, null);
                if (item != null) {
                  //TODO 2 Panggil Fungsi untuk Insert ke DB
                  int result = await dbHelper.insert(item);
                  if (result > 0) {
                    updateListView();
                  }
                }
              },
            ),
          ),
        ),
      ]),
    );
  }

  Future<Barang> navigateToEntryForm(BuildContext context, Barang barang) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return EntryForm(barang);
        }
      )
    );
    return result;
  }

  ListView createListView() {
    // ignore: deprecated_member_use
    TextStyle textStyle = Theme.of(context).textTheme.subhead;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.people),
            ),
            title: Text(
              this.itemList[index].kodeBrg,
              style: textStyle,
            ),
            subtitle: 
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nama : ' + this.itemList[index].namaBrg
                    ),
                    Text(
                      'Stok : ' + this.itemList[index].stokAkhir.toString()
                    ),
                  ],
                ),
              ),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () async {
                //TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan Item
                int result = await dbHelper.delete(this.itemList[index]);
                updateListView();
              },
            ),
            onTap: () async {
              var item =
              await navigateToEntryForm(context, this.itemList[index]);
              //TODO 4 Panggil Fungsi untuk Edit data
              int result = await dbHelper.update(item);
              updateListView();
            },
          ),
        );
      },
    );
  }

  //update List item
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      //TODO 1 Select data dari DB
      Future<List<Barang>> itemListFuture = dbHelper.getBarangList();
      itemListFuture.then((itemList) {
        setState(() {
          this.itemList = itemList;
          this.count = itemList.length;
        });
      });
    });
  }
}