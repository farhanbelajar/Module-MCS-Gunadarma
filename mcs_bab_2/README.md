# **PRAKTIKUM BAB 2**
## DINAMIS UI 
***

## PENDAHULUAN

Pada praktikum bab 2 akan membuat ui secara dinamis menggunakan ListView.builder. UI pada aplikasi akan dibuat secara dinamis berdasarkan data yang tersedia. Gambarannya adalah jika ListView() pada bab 1 berisi widget-widget yang dibuat secara manual, maka di bab ini akan di isi oleh widget-widget di dalam ListView() dibentuk secara otomatis sesuai dengan data yang tersedia.

## PENJELASAN & TAHAP-TAHAP
Tampilan aplikasi yang akan di buat
<div align="center">
  <img src="https://github.com/Rokel15/GUNADARMA-ASCL-MCS/blob/angel-dev/images/gambar-gambar%20bab%202/halaman%20awal%20aplikasi%20bab%202.jpeg" width="300" height="600"/> 
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/Rokel15/GUNADARMA-ASCL-MCS/blob/angel-dev/images/gambar-gambar%20bab%202/halaman%20detail%20aplikasi%20bab%202.jpeg"
width="300" height="600" />
</div>
Tambahkan package google_fonts: ke pubspec.yaml untuk merubah font dari aplikasi dan buat beberapa file .dart seperti di bawah ini:
<div align = "center"> <img src ="https://github.com/user-attachments/assets/3ce9293a-044e-4e1d-ae53-bb6cda8e71c6"width="300" height="300"/>
</div>
Buka file cat_model.dart dan mengisi code seperti ini:

```dart
class CatModel{
  String urlImage;
  String name;
  String desc;

  CatModel({
    required this.urlImage,
    required this.name,
    required this.desc,
  });
}
```
disini Kita membuat class bernama CatModel() beserta constructor di dalamnya. Class CatModel() digunakan sebagai kerangka sebuah data yang memiliki ketentuan dari suatu program. Untuk kegunaan detailnya akan terlihat setelah selesai membuat data dummy.
selanjutnya Buka file bernama cat_data.dart dan berikan code di dalamnya sebagai berikut :

```dart
import 'package:mcs_bab_2/cat_model.dart';

List<CatModel> cats = [
  CatModel(
      urlImage:
      "https://raw.githubusercontent.com/Fahmisbas/acsl-mcs/master/Bab%203%20-%20RecyclerView%20%26%20OnItemClickListener/cats/persia.jpg",
      name: "Persia",
      desc:
      '''Persia merupakan jenis kucing dengan bulu panjang yang lebat dan wajah bulat yang menggemaskan. Mereka dikenal dengan sifat yang tenang, penyayang, dan cocok sebagai kucing peliharaan dalam ruangan.'''),
  CatModel(
      urlImage:
      "https://raw.githubusercontent.com/Fahmisbas/acsl-mcs/master/Bab%203%20-%20RecyclerView%20%26%20OnItemClickListener/cats/ragdoll.png",
      name: "Ragdoll",
      desc:
      '''Ragdoll merupakan kucing besar dengan bulu panjang yang halus dan mata biru memikat. Mereka terkenal dengan kecenderungan mereka untuk rileks dan melonggar saat diangkat, mirip dengan boneka ragdoll, dan sangat penyayang.'''),
  CatModel(
      urlImage:
      "https://raw.githubusercontent.com/Fahmisbas/acsl-mcs/master/Bab%203%20-%20RecyclerView%20%26%20OnItemClickListener/cats/siam.jpeg",
      name: "Siam",
      desc:
      '''Siam merupakan kucing dengan bulu pendek, mata biru tajam, dan tubuh yang ramping. Mereka dikenal sebagai kucing vokal yang suka berbicara dan memiliki kepribadian yang aktif serta ramah.'''),
  CatModel(
      urlImage:
      "https://raw.githubusercontent.com/Fahmisbas/acsl-mcs/master/Bab%203%20-%20RecyclerView%20%26%20OnItemClickListener/cats/sphynx.jpg",
      name: "Sphynx",
      desc:
      '''Sphynx merupakan jenis kucing tanpa bulu yang memiliki kulit lembut seperti kulit jeruk. Mereka sering menjadi perhatian dengan penampilan yang unik dan ramah serta cerdas dalam perilaku mereka.'''),
  CatModel(
      urlImage:
      "https://raw.githubusercontent.com/Fahmisbas/acsl-mcs/master/Bab%203%20-%20RecyclerView%20%26%20OnItemClickListener/cats/maine%20coon.jpg",
      name: "Maine Coon",
      desc:
      '''Maine Coon merupakan salah satu kucing terbesar dengan bulu panjang dan ekor berbulu tebal. Mereka memiliki sifat yang ramah, lembut, dan cenderung energik, serta memiliki fisik yang kuat.'''),
  CatModel(
      urlImage:
      "https://raw.githubusercontent.com/Fahmisbas/acsl-mcs/master/Bab%203%20-%20RecyclerView%20%26%20OnItemClickListener/cats/munchkin.jpg",
      name: "Munchkin",
      desc:
      '''Munchkin merupakan jenis kucing dengan tubuh pendek dan kaki yang lebih pendek dari kucing biasa. Mereka memiliki penampilan unik yang lucu dan aktif dalam bermain.'''),
  CatModel(
      urlImage:
      "https://raw.githubusercontent.com/Fahmisbas/acsl-mcs/master/Bab%203%20-%20RecyclerView%20%26%20OnItemClickListener/cats/bengal.png",
      name: "Bengal",
      desc:
      '''Bengal memiliki bulu yang berkilau dengan motif belang yang mirip macan tutul. Mereka aktif, cerdas, dan suka bermain, sering kali memiliki energi yang tinggi.'''),
  CatModel(
      urlImage:
      "https://raw.githubusercontent.com/Fahmisbas/acsl-mcs/master/Bab%203%20-%20RecyclerView%20%26%20OnItemClickListener/cats/britain%20shorthair.jpg",
      name: "Britain Shorthair",
      desc:
      '''British Shorthair memiliki penampilan gemuk dengan wajah yang bulat dan mata besar. Mereka cenderung tenang, santai, dan mudah diurus, membuat mereka menjadi kucing peliharaan yang populer.''')
];
```
Kita membuat data dummy di dalam suatu List. Data di dalam List dibuat dengan bentuk model dari CatModel dan isi dari List dengan memanggil class CatModel() yang mana CatModel() memiliki constructor untuk pengisian data.
