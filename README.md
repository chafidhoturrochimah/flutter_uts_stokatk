# flutter_uts_stokatk

<ul>
  <li><b>Nama    : Chafidhoturrochimah</b></li>
  <li><b>Kelas   : MI-2B</b></li>
  <li><b>NIM     : 1931710013</b></li>  
</ul><br>
<b>Disini saya membuat Pencatatan Stok Pada Toko ATK (Alat Tulis Kantor). Mini Project ini berisikan 2 tabel yang berelasi. yaitu Tabel Barang dan Kategori. yang dimana tabel kategori ini berelasi dengan tabel barang. tabel kategori memiliki atribut atau variabel idkategori dan namakategori. sedabgkan pada tabel barang memiliki atribut atau variabel id, kodeBrg, idkategori, namaBrg, harga, stokAwal, inBrg(Barang Masuk), outBrg(Barang Keluar), dan stokAkhir. Nahh, pada tabel barang listview itu yang ditampilkan adalah kodeBrg yang menjadi title. idkategori, namaBrg dan stokAkhir(stok) yang menjadi subtitle. Mini project ini memiliki fungsi CRUD(Create, Read, Update, dan Delete). dan tugas UTS saya adalah jika pada listview tabel kategori dihapus, maka listview pada tabel barang yang berelasi dengan kategori yang dihapus juga akan terhapus. pada video demo dibawah ini sudah terlihat. kode untuk tugas uts tersebut adalah dengan menambah sebuah kode di DbHelper bagian deleteKategori, maka kode deleteKategori terlihat sebagai berikut : <br>
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
</b><br>
<b>Berikut ini video demo hasil UTS :</b><br>
  https://drive.google.com/file/d/1-R718lZHCiEVoB9hSRfcp9XIur8ZBbSO/view?usp=sharing 
  


