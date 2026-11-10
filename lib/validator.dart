// 1. Validasi Nama: Wajib isi & minimal 3 huruf
String? validasiNama(String? nilai) {
  final teks = nilai?.trim() ?? '';
  if (teks.isEmpty) return 'Nama wajib diisi';
  if (teks.length < 3) return 'Nama minimal 3 huruf';
  return null; // Valid
}

// 2. Validasi NIM: Wajib isi, hanya angka, & minimal 7 digit
String? validasiNim(String? nilai) {
  final teks = nilai?.trim() ?? '';
  if (teks.isEmpty) return 'NIM wajib diisi';
  
  if (!RegExp(r'^\d+$').hasMatch(teks)) {
    return 'NIM hanya boleh berisi angka';
  }
  
  if (teks.length < 7) return 'NIM minimal 7 digit';
  return null;
}

// 3. Validasi Email: Wajib isi & sesuai pola RegExp email
String? validasiEmail(String? nilai) {
  final teks = nilai?.trim() ?? '';
  if (teks.isEmpty) return 'Email wajib diisi';
  
  final polaEmail = RegExp(r'^[\w.+-]+@[\w-]+(\.[\w-]+)+$');
  if (!polaEmail.hasMatch(teks)) {
    return 'Format email tidak valid (contoh: nama@kampus.ac.id)';
  }
  
  return null;
}

// 4. Validasi Semester: Wajib isi & angka rentang 1 sampai 14
String? validasiSemester(String? nilai) {
  final teks = nilai?.trim() ?? '';
  if (teks.isEmpty) return 'Semester wajib diisi';
  
  final angka = int.tryParse(teks);
  if (angka == null) return 'Semester harus berupa angka';
  if (angka < 1 || angka > 14) return 'Semester harus antara 1 dan 14';
  
  return null;
}

// 5. Validasi No HP
String? validasiNoHp(String? nilai) {
  final teks = nilai?.trim() ?? '';
  
  if (teks.isEmpty) return 'Nomor HP wajib diisi';
  if (!RegExp(r'^\d+$').hasMatch(teks)) return 'Nomor HP hanya boleh berisi angka';
  if (!teks.startsWith('08')) return 'Nomor HP harus diawali "08"';
  if (teks.length < 10 || teks.length > 13) return 'Nomor HP harus antara 10 sampai 13 digit';
  
  return null; // Valid
}
