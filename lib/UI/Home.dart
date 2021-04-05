import 'package:flutter/material.dart';
import 'package:flutter_uts_stokatk/Helpers/DbHelper.dart';
import 'package:flutter_uts_stokatk/Models/Barang.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'EntryFormBarang.dart';

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
        title: Text(
          'Daftar Barang',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'CandaraBold',
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

      body: Column(children: [
        Expanded(
          child: createListView(),
        ),
        Container(
          alignment: Alignment.bottomCenter,
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
          child: SizedBox(
            width: double.infinity,
            // ignore: deprecated_member_use
            child: RaisedButton(
              child: Text(
                "Tambah Barang",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'CandaraBold',
                ),
              ),
              textColor: Colors.white,
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60.0)
              ),
              onPressed: () async {
                var item = await navigateToEntryForm(context, null);
                if (item != null) {
                  //TODO 2 Panggil Fungsi untuk Insert ke DB
                  int result = await dbHelper.insertBarang(item);
                  if (result > 0) {
                    updateListView();
                  }
                }
              },
            ),
          ),
        ),

        Container(
          height: 5.0,
        ),

        Container(
          alignment: Alignment.bottomCenter,
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
          child: SizedBox(
            width: double.infinity,
            // ignore: deprecated_member_use
            child: RaisedButton(
              child: Text(
                "Lihat Kategori",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'CandaraBold',
                ),
              ),
              textColor: Colors.white,
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60.0)
              ),
              onPressed: ()  {
                Navigator.pushNamed(context, '/');
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
          return EntryFormBarang(barang);
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
              backgroundColor: Colors.amber,
              child: Icon(Icons.people),
            ),
            title: Text(
              this.itemList[index].kodeBrg,
              style: TextStyle(
                fontFamily: 'CandaraBold',
              ),
            ),
            subtitle: 
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kategori : ' + this.itemList[index].idkategori.toString(),
                      style: TextStyle(
                        fontFamily: 'Candara',
                      ),
                    ),
                    Text(
                      'Nama : ' + this.itemList[index].namaBrg,
                      style: TextStyle(
                        fontFamily: 'Candara',
                      ),
                    ),
                    Text(
                      'Stok : ' + this.itemList[index].stokAkhir.toString(),
                      style: TextStyle(
                        fontFamily: 'Candara',
                      ),
                    ),
                  ],
                ),
              ),
            trailing: GestureDetector(
              child: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onTap: () async {
                //TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan Item
                int result = await dbHelper.deleteBarang(this.itemList[index]);
                updateListView();
              },
            ),
            onTap: () async {
              var item =
              await navigateToEntryForm(context, this.itemList[index]);
              //TODO 4 Panggil Fungsi untuk Edit data
              int result = await dbHelper.updateBarang(item);
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
      Future<List<Barang>> itemListFuture = dbHelper.getItemList();
      itemListFuture.then((itemList) {
        setState(() {
          this.itemList = itemList;
          this.count = itemList.length;
        });
      });
    });
  }
}