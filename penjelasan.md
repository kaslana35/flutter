# Dokumentasi & Panduan Belajar Aplikasi Akademik

Dokumen ini berisi penjelasan arsitektur dan logika pemrograman aplikasi Flutter "Akademik Mahasiswa" untuk memudahkan proses pembelajaran.

## 1. Arsitektur Komponen
- **`DashboardPage`**: Halaman utama (Home). Menampilkan daftar mahasiswa dari `daftarMahasiswa` (Global List).
- **`TambahMahasiswaPage`**: Halaman formulir input. Menggunakan `GlobalKey<FormState>` untuk mengontrol validasi.
- **`DetailMahasiswaPage`**: Halaman rincian data. Menggunakan parameter constructor untuk menerima data mahasiswa yang diklik.
- **`ProfilPage`**: Halaman statis untuk informasi pengembang.
- **`BarisInfo`**: Komponen reusable untuk menampilkan format "Label : Nilai" secara konsisten.

## 2. Mekanisme Validasi (`validator.dart`)
Validasi dilakukan sebelum data diproses menggunakan fungsi *predikat*:
- Fungsi menerima `String?` (bisa kosong).
- Mengembalikan `String` (pesan kesalahan) jika input tidak valid.
- Mengembalikan `null` jika input benar.
- **Fungsi utama**: `validasiNama`, `validasiNim`, `validasiEmail`, `validasiSemester`, `validasiNoHp`.

## 3. Logika Utama Aplikasi
### A. Pengelolaan State (State Management)
Aplikasi menggunakan `setState()` untuk memperbarui tampilan secara otomatis. Saat tombol "Simpan" ditekan, `setState` akan:
1. Memperbarui `_hasil` (pratinjau lokal).
2. Menambah data baru ke dalam `daftarMahasiswa` sehingga dashboard langsung ter-update (re-render).

### B. Controller & Focus
- **`TextEditingController`**: "Ember" penyimpan teks yang diketik pengguna di kolom input.
- **`FocusNode`**: Pengatur kursor otomatis. Contoh: memanggil `_namaF.requestFocus()` setelah tombol "Kosongkan" ditekan untuk mempermudah user menginput ulang.

### C. Navigasi
Aplikasi menggunakan pola **Stack Navigation**:
- `Navigator.push(...)`: Menambahkan halaman ke tumpukan (pergi ke detail/form).
- `Navigator.pop(context)`: Menghapus halaman teratas dari tumpukan (kembali).

## 4. Alur Kerja Tombol Simpan
1. `FocusScope.of(context).unfocus()`: Menutup keyboard virtual.
2. `_formKey.currentState!.validate()`: Memicu semua validator di form.
3. **Jika Valid**: Data dibungkus ke dalam `Map<String, String>`, ditambahkan ke daftar (`daftarMahasiswa.add`), dan memberikan *feedback* lewat `SnackBar`.
4. **Jika Tidak Valid**: Mengubah `AutovalidateMode` menjadi `onUserInteraction` agar pesan error merah langsung muncul di kolom yang salah.
