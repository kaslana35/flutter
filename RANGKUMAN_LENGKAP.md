# Rangkuman Lengkap Proyek: Aplikasi Akademik Mahasiswa (Flutter)

Dokumen ini adalah ringkasan menyeluruh dari awal pembuatan proyek hingga pengujian akhir, dirancang khusus untuk dokumentasi pribadi, laporan praktikum, atau persiapan presentasi tugas.

---

## 1. Latar Belakang & Tujuan Proyek
Proyek ini dibuat untuk memenuhi tugas mata kuliah Pemrograman Mobile/Flutter (Studi Kasus: Pertemuan 5 - Form Input & Validasi). Aplikasi ini dirancang agar mampu mengelola data mahasiswa secara dinamis, mulai dari melihat daftar di Dashboard, menambah data baru dengan validasi ketat, melihat rincian data (Detail), hingga melihat profil pengembang.

---

## 2. Struktur Proyek & Arsitektur Direktori
Proyek ini menggunakan struktur modular yang bersih (*clean architecture* ala Flutter):
```text
lib/
├── main.dart              # Titik masuk utama & logika form/state
├── validator.dart         # Kumpulan fungsi validasi (Trust Boundary)
└── screens/
    └── dashboard.dart     # Halaman utama (Home & List Mahasiswa)
test/
└── widget_test.dart       # Pengujian otomatis (Unit Test & Widget Test)
```

---

## 3. Penjelasan Masing-Masing Halaman & Komponen

### A. Dashboard Utama (`DashboardPage`)
* **File**: `lib/screens/dashboard.dart`
* **Fungsi**: Menjadi halaman pertama yang dilihat pengguna.
* **Fitur**:
  * Menampilkan daftar mahasiswa (`daftarMahasiswa`).
  * Tombol pintasan (*Floating Action Button*) berikon tambah untuk membuka form.
  * Kartu navigasi cepat menuju halaman *Profil* dan *Detail*.

### B. Form Tambah & Validasi Mahasiswa (`TambahMahasiswaPage`)
* **File**: `lib/main.dart`
* **Fungsi**: Formulir untuk memasukkan data mahasiswa baru.
* **Fitur Unggulan**:
  * **Sistem Validasi Otomatis**: Memeriksa input secara *real-time* atau saat tombol simpan ditekan.
  * **Auto-Sync ke Dashboard**: Data yang berhasil disimpan akan langsung masuk ke list di Dashboard tanpa perlu *restart* aplikasi.
  * **Tombol Kosongkan (Reset)**: Menghapus semua input dan mengembalikan fokus kursor otomatis ke kolom Nama (`FocusNode`).
  * **Pratinjau Data**: Menampilkan kotak informasi data yang baru saja divalidasi.

### C. Halaman Detail Mahasiswa (`DetailMahasiswaPage`)
* **File**: `lib/main.dart`
* **Fungsi**: Menampilkan rincian data mahasiswa secara spesifik.
* **Cara Kerja**: Menerima parameter `Map<String, String>` dari data yang diklik di dashboard, lalu merendernya ke dalam komponen `BarisInfo`.

### D. Halaman Profil (`ProfilPage`)
* **File**: `lib/main.dart`
* **Fungsi**: Menampilkan informasi identitas pengembang/mahasiswa (Nama, Kelas, Kampus, Email) serta daftar keahlian (*skills*).

### E. Sistem Validasi (`validator.dart`)
* **File**: `lib/validator.dart`
* **Fungsi**: Berisi fungsi logika murni (*pure functions*) untuk menyaring input:
  * `validasiNama`: Minimal 3 karakter.
  * `validasiNim`: Hanya angka (`\d+`), minimal 7 digit.
  * `validasiEmail`: Sesuai pola standar surel (`@` dan domain).
  * `validasiSemester`: Berupa angka antara 1 sampai 14.
  * `validasiNoHp`: Wajib angka, diawali awalan `"08"`, dengan panjang 10–13 digit.

---

## 4. Proses Pengujian & Kualitas Kode (Testing & Analysis)
Untuk memastikan aplikasi bebas dari *bug* dan memenuhi standar industri:
* **Analisis Statis (`flutter analyze`)**: Berhasil dijalankan dan menghasilkan status **`No issues found!`** (kodingan bersih tanpa peringatan/error).
* **Pengujian Otomatis (`flutter test`)**: Meliputi:
  1. *Unit Test* untuk menguji seluruh fungsi validator (`validator.dart`).
  2. *Widget & Integration Test* untuk menguji antarmuka Dashboard dan alur navigasi tombol Tambah.
  3. Hasil akhir pengujian: **`All tests passed!`**.

---

## 5. Kesimpulan
Aplikasi ini telah memenuhi seluruh standar koding modern:
* Menerapkan pemisahan tugas (*Separation of Concerns*).
* Memiliki sistem keamanan input (*Input Validation*).
* Dilengkapi dokumentasi pengujian otomatis.
* Siap didemonstrasikan atau dikumpulkan sebagai tugas akhir praktikum.
