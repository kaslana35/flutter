import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/validator.dart';

void main() {
  group('1. Unit Test Validator (Aturan Validasi)', () {
    test('Validasi Nama', () {
      expect(validasiNama(''), 'Nama wajib diisi');
      expect(validasiNama('Ri'), 'Nama minimal 3 huruf');
      expect(validasiNama('Rina Amelia'), null); // Valid
    });

    test('Validasi NIM', () {
      expect(validasiNim(''), 'NIM wajib diisi');
      expect(validasiNim('2023a01'), 'NIM hanya boleh berisi angka');
      expect(validasiNim('123456'), 'NIM minimal 7 digit');
      expect(validasiNim('2023001'), null); // Valid
    });

    test('Validasi Email', () {
      expect(validasiEmail(''), 'Email wajib diisi');
      expect(validasiEmail('salah-format'), 'Format email tidak valid (contoh: nama@kampus.ac.id)');
      expect(validasiEmail('rina@kampus.ac.id'), null); // Valid
    });

    test('Validasi Semester', () {
      expect(validasiSemester(''), 'Semester wajib diisi');
      expect(validasiSemester('abc'), 'Semester harus berupa angka');
      expect(validasiSemester('0'), 'Semester harus antara 1 dan 14');
      expect(validasiSemester('15'), 'Semester harus antara 1 dan 14');
      expect(validasiSemester('5'), null); // Valid
    });

    test('Validasi No HP', () {
      expect(validasiNoHp(''), 'Nomor HP wajib diisi');
      expect(validasiNoHp('0812a345678'), 'Nomor HP hanya boleh berisi angka');
      expect(validasiNoHp('09123456789'), 'Nomor HP harus diawali "08"');
      expect(validasiNoHp('08123'), 'Nomor HP harus antara 10 sampai 13 digit');
      expect(validasiNoHp('081234567890'), null); // Valid
    });
  });

  group('2. Widget & Integration Test (Tampilan & Navigasi)', () {
    testWidgets('Cek Dashboard dan Tombol Tambah Mahasiswa', (WidgetTester tester) async {
      // 1. Jalankan aplikasi
      await tester.pumpWidget(const MyApp());

      // 2. Pastikan judul Dashboard muncul
      expect(find.text('Dashboard Akademik'), findsOneWidget);
      expect(find.text('Rina Amelia'), findsOneWidget);

      // 3. Ketuk tombol 'Tambah' untuk pindah ke form
      await tester.tap(find.text('Tambah'));
      await tester.pumpAndSettle(); // Tunggu animasi navigasi selesai

      // 4. Pastikan halaman 'Tambah Mahasiswa' terbuka
      expect(find.text('Tambah Mahasiswa'), findsOneWidget);
      expect(find.text('Simpan'), findsOneWidget);
    });
  });
}
