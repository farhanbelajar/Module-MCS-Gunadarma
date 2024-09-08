# **PRAKTIKUM MCS BAB 1**

## **Widget-widget dasar pada Flutter**

## **PENDAHULUAN**

Pada praktikum MCS bab 1, praktikan akan diajarkan mengenai widget-widget dasar yang ada pada flutter yang digunakan untuk membentuk suatu halaman aplikasi. Selain itu, praktikan juga akan langsung mengimplementasikan widget-widget tersebut dalam membentuk sebuah aplikasi.

* **MaterialApp()**

  MaterialApp() merupakan widget paling dasar yang berfungsi sebagai fondasi yang mengatur konfigurasi umum dari aplikasi. Untuk menggunakan widget ini, pengguna harus melakukan import terhadap 'package:flutter/material.dart'. Berikut merupakan struktur dari widget MaterialApp():
```dart
MaterialApp(
 title: ...,
 debugShowCheckedModeBanner: ...,
 theme: ...,
 home: ....
 initialRoute: ...,
 routes: {...}
 //dan lain lain
);
```

* **Scaffold()**
  
  Scaffold() merupakan widget umum yang digunakan untuk membentuk halaman pada sebuah aplikasi. Widget ini memiliki berbagai macam properti, seperti **appBar:**, **body:**, **floatingActionButton:**, **drawer:**, **bottomNavigationBar:** dan lain-lain. Berikut merupakan struktur dari widget scaffold():
```dart
Scaffold(
 appBar: ...,
 body: ...,
 floatingActionButton: ...,
 drawer: ...,
 bottomNavigationBar: ...,
)
```
Untuk menggunakan berbagai jenis widget yang tersedia pada flutter, kita wajib mengextends class yang akan membentuk aplikasi dengan memilih salah satu diantara 2 widget, yaitu **StatelessWidget()** atau **StatefulWidget()**. Berikut beberapa perbedaan antara StatelessWidget() dengan StatefulWidget():

***StatelessWidget**

## **PRAKTIKUM BAB 1**

Tampilan aplikasi yang akan dibangun:

![images/gambar-gambar bab 1/halaman aplikasi1.jpeg](https://github.com/Rokel15/GUNADARMA-ASCL-MCS/blob/zaidan-dev/images/gambar-gambar%20bab%201/halaman%20aplikasi1.jpeg)
