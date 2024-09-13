# **PRAKTIKUM BAB 4**
## STATE MANAGEMENT PROVIDER 
***

## PENDAHULUAN

Pada praktikum MCS bab 4 akan belajar State Management Provider. Dalam flutter segala bentuk kondisi, aksi, perpindahan/perubahan data ataupun segala sesuatu yang sekiranya akan mempengaruhi tampilan di sebut State. Sehingga State Management adalah cara dari aplikasi untuk mengatur, mengelola dan menangani state secara efisien terutama saat data atau state tersebut melibatkan beberapa widget. 
Flutter menyediakan banyak package untuk State Management, diantaranya adalah setstate, provider, bloc, getx ataupun riverpod. Provider merupakan salah satu package State Management yang menawarkan efisiensi, kesederhanaan dan fleksibilitas dalam hal mengelola state yang melibatkan beberapa widget tanpa harus melewati widget secara manual. Berikut perbedaannya

(foto tanpa provider)
Tanpa provider proses flow atau alur state panjang karena bussines logic tergabung dengan UI. Penggabungan tersebut akan membuat state harus diturunkan secara manual menggunakan constructor atau widget parameter dari widget induk ke widget anaknya (metode ini disebut prop drilling). Semakin kompleks dan dalam susunan hirarki widget pada suatu aplikasi maka semakin banyak level yang harus di lewati state tersebut meskipun diantaranya tidak membutuhkan state tersebut. Hal akan membuat code menjadi rumit dan sulit untuk di maintenance. Flow di dalamnya pun menjadi tidak efisien.

(foto dengan provider)
Sedangkan saat menggunakan provider, bussines logic akan dibuat terpisah dari UI. State akan dikelola secara terpusat sehingga dapat diakses oleh widget manapun tanpa harus melewati widget induk terlebih dahulu. Provider memungkinkan widget untuk mendengar (listen) state yang ada tanpa harus meneruskan data melalui constructor atau parameter.

Aplikasi yang akan dibuat pada bab 4 ini adalah aplikasi input data sederhana yang akan menggunakan provider untuk mengelola statenya. Meskipun dapat menginput data, aplikasi ini tidak berfokus pada bagaimana data disimpan seperti pada bab sebelumnya. Sehingga data hanya disimpan pada sebuah List. Fokus dari aplikasi ini adalah bagaimana cara menerapkan dan menggunakan provider untuk mengelola state dengan memisahkan bussines logic dengan UI




## PENJELASAN & TAHAP-TAHAP
Tampilan aplikasi yang akan di buat
<div align="center">
  <img src="https://github.com/Rokel15/GUNADARMA-ASCL-MCS/blob/angel-dev/images/gambar-gambar%20bab%202/halaman%20awal%20aplikasi%20bab%202.jpeg" width="300" height="600"/> 
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/Rokel15/GUNADARMA-ASCL-MCS/blob/angel-dev/images/gambar-gambar%20bab%202/halaman%20detail%20aplikasi%20bab%202.jpeg"
width="300" height="600" />
</div>
