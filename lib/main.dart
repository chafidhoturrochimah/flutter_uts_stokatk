//kode utama Aplikasi tampilan awal
import 'package:flutter/material.dart';
import 'package:flutter_uts_stokatk/UI/EntryFormBarang.dart';
import 'package:flutter_uts_stokatk/UI/HomeKategori.dart';
import 'UI/Home.dart';

//package letak folder Anda
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kategori',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: 
      '/',
      routes: {
        '/':(context) => HomeKategori(),
        '/barang': (context) => Home(),
      },
    );
  }
}
