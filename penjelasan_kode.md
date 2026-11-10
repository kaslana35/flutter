# Penjelasan Kode Baris per Baris (`lib/main.dart`)

Panduan ini disiapkan khusus untuk memudahkan pemahaman dan persiapan presentasi/demo tugas pemrograman Flutter.

---

## 1. Struktur Awal & Konfigurasi Utama

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'validator.dart';
import 'screens/dashboard.dart';
```
* **Penjelasan**: 
  * `material.dart`: Pustaka inti wajib untuk membangun tampilan UI bergaya Material Design di Flutter.
  * `services.dart`: Digunakan untuk membatasi input (misalnya hanya mengizinkan angka pada NIM dan No HP).
  * `validator.dart` & `screens/dashboard.dart`: Memanggil file eksternal agar kodingan di `main.dart` tetap bersih dan modular.

```dart
void main() {
  runApp(const MyApp());
}
```
* **Penjelasan**: Titik awal eksekusi program. Perintah `runApp` memberitahu Flutter untuk merender widget utama (`MyApp`) ke layar HP atau emulator.

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Akademik Mahasiswa',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const DashboardPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
```
* **Penjelasan**: 
  * `MyApp` adalah widget akar (*root widget*).
  * `MaterialApp`: Kerangka utama aplikasi (mengatur tema warna `teal`, judul, dan menghilangkan label *Debug* di pojok kanan atas).
  * `home: const DashboardPage()`: Menentukan halaman pertama yang dilihat pengguna saat aplikasi dibuka.

---

## 2. Penyimpanan Data (Database Sementara)

```dart
List<Map<String, String>> daftarMahasiswa = [
  {'nama': 'Rina Amelia', 'nim': '2023001', 'prodi': 'Sistem Informasi', 'semester': '5', 'email': 'rina@contoh.ac.id', 'hp': '081234567890'},
  ...
];
```
* **Penjelasan**: 
  * Variabel global berupa **List of Map** yang bertindak sebagai "database lokal" sementara untuk menyimpan data mahasiswa yang tampil di Dashboard.

---

## 3. Logika Form & State (`TambahMahasiswaPage`)

Bagian ini adalah inti dari tugas validasi form.

```dart
class TambahMahasiswaPage extends StatefulWidget {
  const TambahMahasiswaPage({super.key});

  @override
  State<TambahMahasiswaPage> createState() => _TambahMahasiswaPageState();
}

class _TambahMahasiswaPageState extends State<TambahMahasiswaPage> {
```
* **Penjelasan**: Menggunakan `StatefulWidget` karena halaman ini memiliki data yang dinamis (bisa berubah-ubah saat user mengetik, menekan tombol, atau memvalidasi form).

```dart
  final _formKey = GlobalKey<FormState>();
  final _namaC = TextEditingController();
  final _nimC = TextEditingController();
  ...
  final _namaF = FocusNode();
```
* **`_formKey`**: Remote control untuk mengecek validasi seluruh form sekaligus.
* **`TextEditingController` (`_namaC`, dll)**: Ember penampung teks yang diketik pengguna pada kolom input.
* **`FocusNode` (`_namaF`)**: Pengatur kursor aktif (digunakan untuk mengembalikan fokus ke kolom nama saat tombol *Kosongkan* ditekan).

```dart
  @override
  void dispose() {
    _namaC.dispose(); _nimC.dispose(); ...
    super.dispose();
  }
```
* **Penjelasan**: Fungsi `dispose` wajib dipanggil untuk menghapus controller dari memori saat halaman ditutup guna mencegah kebocoran memori (*memory leak*).

### A. Fungsi Tombol Simpan (`_simpan`)
```dart
  void _simpan() {
    FocusScope.of(context).unfocus(); // Menutup keyboard virtual
    if (_formKey.currentState!.validate()) { // Cek apakah semua input valid
      final newData = {
        'nama': _namaC.text.trim(), 
        'nim': _nimC.text.trim(), 
        'prodi': 'Sistem Informasi',
        'semester': _semC.text.trim(),
        'email': _emailC.text.trim(), 
        'hp': _hpC.text.trim()
      };
      
      setState(() {
        _hasil = newData;
        daftarMahasiswa.add(newData); // Tambah data ke list dashboard secara otomatis!
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data ${_hasil!['nama']} berhasil disimpan!')),
      );
    } else {
      setState(() => _mode = AutovalidateMode.onUserInteraction);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Periksa kembali isian!')));
    }
  }
```
* **Penjelasan**: 
  1. Menutup keyboard agar layar bersih.
  2. Memvalidasi form. Jika lolos (`null` dari validator), data dibungkus dan dimasukkan ke `daftarMahasiswa`.
  3. `setState` memicu Flutter untuk menggambar ulang tampilan sehingga data baru langsung muncul di Dashboard.

### B. Fungsi Tombol Kosongkan (`_kosongkan`)
```dart
  void _kosongkan() {
    _formKey.currentState!.reset(); // Mereset status error form
    _namaC.clear(); _nimC.clear(); ... // Menghapus teks di input
    setState(() { _hasil = null; _mode = AutovalidateMode.disabled; });
    _namaF.requestFocus(); // Memindahkan kursor kembali ke kolom Nama
  }
```

---

## 4. Komponen Halaman Detail & Profil

```dart
class DetailMahasiswaPage extends StatelessWidget {
  const DetailMahasiswaPage({super.key, required this.mahasiswa});
  final Map<String, String> mahasiswa;
```
* **Penjelasan**: Halaman ini bersifat dinamis karena menerima parameter `mahasiswa` melalui *constructor* saat diklik dari dashboard.

```dart
class ProfilPage extends StatelessWidget {
  ...
}
```
* **Penjelasan**: Halaman statis yang menampilkan informasi identitas pengembang aplikasi beserta daftar keahlian menggunakan looping `for`.

---

## 5. Komponen Reusable (`BarisInfo`)

```dart
class BarisInfo extends StatelessWidget {
  const BarisInfo({super.key, required this.label, required this.nilai});
  final String label;
  final String nilai;
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Row(children: [
      SizedBox(width: 100, child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold))),
      Text(': $nilai'),
    ]));
  }
}
```
* **Penjelasan**: Widget kustom yang dibuat sekali untuk mencetak baris teks berformat `Label : Nilai`. Menghemat banyak baris kode pada halaman *Detail* dan *Profil*.
