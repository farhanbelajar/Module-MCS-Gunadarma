# **PRAKTIKUM BAB 4**
## STATE MANAGEMENT PROVIDER 
***

## PENDAHULUAN

Pada praktikum MCS bab 4 akan belajar State Management Provider. Dalam flutter segala bentuk kondisi, aksi, perpindahan/perubahan data ataupun segala sesuatu yang sekiranya akan mempengaruhi tampilan di sebut **State**. Sehingga **State Management adalah cara dari aplikasi untuk mengatur, mengelola dan menangani state secara efisien terutama saat data atau state tersebut melibatkan beberapa widget**. Flutter menyediakan banyak package untuk State Management, diantaranya adalah setstate, provider, bloc, getx ataupun riverpod. Provider merupakan salah satu package State Management yang menawarkan efisiensi, kesederhanaan dan fleksibilitas dalam hal mengelola state yang melibatkan beberapa widget tanpa harus melewati widget secara manual. Berikut perbedaannya

<div align="center">
  <br>
  <img src="https://github.com/Rokel15/GUNADARMA-ASCL-MCS/blob/dev-aini/images/gambar-gambar%20bab%204/tanpa_provider.jpg" width="578" height="268"/> 
</div>
Tanpa provider proses flow atau alur state panjang karena bussines logic tergabung dengan UI. Penggabungan tersebut akan membuat state harus diturunkan secara manual menggunakan constructor atau widget parameter dari widget induk ke widget anaknya (metode ini disebut prop drilling). Semakin kompleks dan dalam susunan hirarki widget pada suatu aplikasi maka semakin banyak level yang harus di lewati state tersebut meskipun diantaranya tidak membutuhkan state tersebut. Hal akan membuat code menjadi rumit dan sulit untuk di maintenance. Flow di dalamnya pun menjadi tidak efisien.

<div align="center">
  <br>
  <br>
  <img src="https://github.com/Rokel15/GUNADARMA-ASCL-MCS/blob/dev-aini/images/gambar-gambar%20bab%204/dengan_provider.jpg" width="578" height="268"/> 
</div>
Sedangkan saat menggunakan provider, bussines logic akan dibuat terpisah dari UI. State akan dikelola secara terpusat sehingga dapat diakses oleh widget manapun tanpa harus melewati widget induk terlebih dahulu. Provider memungkinkan widget untuk mendengar (listen) state yang ada tanpa harus meneruskan data melalui constructor atau parameter.
<br>
<br>
Aplikasi yang akan dibuat pada bab 4 ini adalah aplikasi input data sederhana yang akan menggunakan provider untuk mengelola statenya. Meskipun dapat menginput data, aplikasi ini tidak berfokus pada bagaimana data disimpan seperti pada bab sebelumnya. Sehingga data hanya disimpan pada sebuah List. Fokus dari aplikasi ini adalah bagaimana cara menerapkan dan menggunakan provider untuk mengelola state dengan memisahkan bussines logic dengan UI


## PENJELASAN & TAHAP-TAHAP
Tampilan aplikasi yang akan di buat
<div align="center">
  <img src="https://github.com/Rokel15/GUNADARMA-ASCL-MCS/blob/dev-aini/images/gambar-gambar%20bab%204/input_screen.jpeg" width="300" height="600"/> 
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/Rokel15/GUNADARMA-ASCL-MCS/blob/dev-aini/images/gambar-gambar%20bab%204/detail_screen.jpeg"
width="300" height="600" />
</div>

Buatlah project flutter baru pada android studio dan pilihlah tempat untuk menyimpan project tersebut. Setelah project selesai terbentuk, buatlah beberapa file **_.dart_** di dalam **_folder lib_** dan tambahkan beberapa package berikut ke dalam file **_pubspec.yaml_**
(INPUT PHOTO HERE)
<br>
Buat model sebagai kerangka dari List yang akan menghandle data yang akan di input dengan menambahkan barisan code pada file **_model.dart_**
```dart 
import 'dart:io' as io;

class Model{
  io.File? image;
  int? npm;
  String? name;
  String? desc;

  Model({
    required this.image,
    required this.npm,
    required this.name,
    required this.desc,
  });
}
```
Class ini digunakan untuk merepresentasikan data yang nanti akan digunakan atau diinputkan oleh user. Class model ini terdiri dari properti yang berisi nama dari variabel beserta tipe datanya seperti variabel image yang berupa io file (input/output file), npm yang berupa int (angka), serta name dan desc yang merupakan string. Properti ini seperti melakukan inisialisasi variabel untuk data yang akan digunakan nanti sehingga dapat lebih terstruktur dan mudah untuk dimanupulasi
<br><br>
Selain properti, terdapat constructor yang menginisialisasi properti ketika ada objek baru dibuat. Ketika sistem akan membuat object baru (dalam contoh kasus ini user menginputkan data baru) constructor ini akan dipanggil dan memastikan semua data terisi karena menggunakan kata kunci required. 

<br><br>
Kemudian buka **_file app_provider.dart_** dan tambahkan kode berikut:
```dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;
import 'package:mcs_bab_4/models/model.dart';
import 'package:mcs_bab_4/screens/profile_screen.dart';

class AppProvider extends ChangeNotifier{
  List<Model> data = [];
  io.File? image;
  ImagePicker imagePicker = ImagePicker();
  TextEditingController inputNpmController = TextEditingController();
  TextEditingController inputNameController = TextEditingController();
  TextEditingController inputDescController = TextEditingController();
  String npmLabel = 'Npm :';
  String nameLabel = 'Name :';
  String descLabel = 'Desc :';
  int? index;
  io.File? imageProfile;
  int? npm;
  String? name;
  String? desc;

  @override
  void dispose(){
    super.dispose();
    inputNpmController.dispose();
    inputNameController.dispose();
    inputDescController.dispose();
  }

  imageFromCamera() async{
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    io.File image = io.File(pickedFile!.path);
    this.image = image;
    notifyListeners();
  }

  imageFromGallery() async{
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    io.File image = io.File(pickedFile!.path);
    this.image = image;
    notifyListeners();
  }

  addData() async{
    data.add(
        Model(
          image: image,
          npm: int.parse(inputNpmController.text),
          name: inputNameController.text,
          desc: inputDescController.text,
        ));
    image = null;
    inputNpmController.text = "";
    inputNameController.text = "";
    inputDescController.text = "";
    notifyListeners();
  }

  deleteData({
    required BuildContext context,
  }) async{
    await data.removeAt(index!);
    Navigator.pop(context);
    notifyListeners();
  }

  goToProfileScreen({
    required BuildContext context,
    required int index,
    required Model model,
  }) async{
    this.index = index;
    imageProfile = await model.image;
    npm = await model.npm;
    name = await model.name;
    desc = await model.desc;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfileScreen(),),
    );
    notifyListeners();
  }
}
```
Secara garis besar, file ini berisi class dengan nama AppProvider yang berfungsi untuk mengelola bussines logic termasuk state menggunakan ChangeNotifier yang nantinya akan memberi tau widget lain kalau terjadi perubahan state yang nantinya akan mempengaruhi tampilan UI. Class ini juga akan menangani controller dan fungsi dari masing masing widget utama pada aplikasi ini. Blok awal kode merupakan inisialisasi properti seperti inisialisasi List sebagai wadah penyimpanan data inputan user,  nama variabel sampai controller widget. <br>
Blok selanjutnya yaitu method dispose() yang akan menjalankan fungsi pembersihan (dispose) controller dari textfield saat sudah tidak digunakan untuk mencegah kebocoran memori. 
Penjelasan tiap fungsi/method yang ada:
