import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'validator.dart';
import 'screens/dashboard.dart';

void main() {
  runApp(const MyApp());
}

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

// Data contoh untuk Dashboard
List<Map<String, String>> daftarMahasiswa = [
  {'nama': 'Rina Amelia', 'nim': '2023001', 'prodi': 'Sistem Informasi', 'semester': '5', 'email': 'rina@contoh.ac.id', 'hp': '081234567890'},
  {'nama': 'Budi Santoso', 'nim': '2023002', 'prodi': 'Sistem Informasi', 'semester': '5', 'email': 'budi@contoh.ac.id', 'hp': '081234567891'},
  {'nama': 'Siti Rahma', 'nim': '2023003', 'prodi': 'Sistem Informasi', 'semester': '3', 'email': 'siti@contoh.ac.id', 'hp': '081234567892'},
];

// ================= HALAMAN 4: FORM TAMBAH MAHASISWA =================
class TambahMahasiswaPage extends StatefulWidget {
  const TambahMahasiswaPage({super.key});

  @override
  State<TambahMahasiswaPage> createState() => _TambahMahasiswaPageState();
}

class _TambahMahasiswaPageState extends State<TambahMahasiswaPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaC = TextEditingController();
  final _nimC = TextEditingController();
  final _emailC = TextEditingController();
  final _semC = TextEditingController();
  final _hpC = TextEditingController(); // Tambahan No HP
  final _namaF = FocusNode();
  
  AutovalidateMode _mode = AutovalidateMode.disabled;
  Map<String, String>? _hasil;

  @override
  void dispose() {
    _namaC.dispose(); _nimC.dispose(); _emailC.dispose(); _semC.dispose(); _hpC.dispose(); _namaF.dispose();
    super.dispose();
  }

  void _simpan() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
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
        daftarMahasiswa.add(newData); // Otomatis masuk ke daftar dashboard!
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data ${_hasil!['nama']} berhasil disimpan ke daftar!')),
      );
    } else {
      setState(() => _mode = AutovalidateMode.onUserInteraction);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Periksa kembali isian!')));
    }
  }

  void _kosongkan() {
    _formKey.currentState!.reset();
    _namaC.clear(); _nimC.clear(); _emailC.clear(); _semC.clear(); _hpC.clear();
    setState(() { _hasil = null; _mode = AutovalidateMode.disabled; });
    _namaF.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Mahasiswa')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey, autovalidateMode: _mode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(controller: _namaC, focusNode: _namaF, autofocus: true, textInputAction: TextInputAction.next, decoration: const InputDecoration(labelText: 'Nama', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()), validator: validasiNama),
              const SizedBox(height: 16),
              TextFormField(controller: _nimC, keyboardType: TextInputType.number, textInputAction: TextInputAction.next, inputFormatters: [FilteringTextInputFormatter.digitsOnly], decoration: const InputDecoration(labelText: 'NIM', prefixIcon: Icon(Icons.badge), border: OutlineInputBorder()), validator: validasiNim),
              const SizedBox(height: 16),
              TextFormField(controller: _emailC, keyboardType: TextInputType.emailAddress, textInputAction: TextInputAction.next, decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email), border: OutlineInputBorder()), validator: validasiEmail),
              const SizedBox(height: 16),
              TextFormField(controller: _semC, keyboardType: TextInputType.number, textInputAction: TextInputAction.next, inputFormatters: [FilteringTextInputFormatter.digitsOnly], decoration: const InputDecoration(labelText: 'Semester', prefixIcon: Icon(Icons.school), border: OutlineInputBorder()), validator: validasiSemester),
              const SizedBox(height: 16),
              TextFormField(controller: _hpC, keyboardType: TextInputType.phone, textInputAction: TextInputAction.done, inputFormatters: [FilteringTextInputFormatter.digitsOnly], decoration: const InputDecoration(labelText: 'No HP', prefixIcon: Icon(Icons.phone), border: OutlineInputBorder()), validator: validasiNoHp, onFieldSubmitted: (_) => _simpan()),
              const SizedBox(height: 24),
              FilledButton.icon(onPressed: _simpan, icon: const Icon(Icons.save), label: const Text('Simpan')),
              const SizedBox(height: 8),
              OutlinedButton.icon(onPressed: _kosongkan, icon: const Icon(Icons.refresh), label: const Text('Kosongkan')),
              if (_hasil != null) ...[
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.primaryContainer, borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Pratinjau Data Valid (Tersimpan)', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      BarisInfo(label: 'Nama', nilai: _hasil!['nama']!),
                      BarisInfo(label: 'NIM', nilai: _hasil!['nim']!),
                      BarisInfo(label: 'Email', nilai: _hasil!['email']!),
                      BarisInfo(label: 'Semester', nilai: _hasil!['semester']!),
                      BarisInfo(label: 'No HP', nilai: _hasil!['hp']!),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// =================== KOMPONEN PENDUKUNG ===================
class DetailMahasiswaPage extends StatelessWidget {
  const DetailMahasiswaPage({super.key, required this.mahasiswa});
  final Map<String, String> mahasiswa;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Mahasiswa')),
      body: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
        BarisInfo(label: 'Nama', nilai: mahasiswa['nama'] ?? '-'),
        BarisInfo(label: 'NIM', nilai: mahasiswa['nim'] ?? '-'),
        BarisInfo(label: 'Prodi', nilai: mahasiswa['prodi'] ?? '-'),
        BarisInfo(label: 'Semester', nilai: mahasiswa['semester'] ?? '-'),
        BarisInfo(label: 'Email', nilai: mahasiswa['email'] ?? '-'),
        BarisInfo(label: 'No HP', nilai: mahasiswa['hp'] ?? '-'),
        const SizedBox(height: 24),
        FilledButton.icon(
          onPressed: () => Navigator.pop(context), 
          icon: const Icon(Icons.arrow_back), 
          label: const Text('Kembali ke Dashboard'),
        ),
      ])),
    );
  }
}

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  static const Map<String, String> profil = {
    'Nama': 'Bayu',
    'Kelas': '5A Sistem Informasi',
    'Kampus': 'UIN Jambi',
    'Email': 'bayu@student.uinjambi.ac.id',
  };

  static const List<String> keahlian = ['Flutter', 'Laravel', 'Basis Data'];

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Mahasiswa'),
        backgroundColor: warna.primaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: warna.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const CircleAvatar(radius: 36, child: Icon(Icons.person, size: 40)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profil['Nama']!,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text('${profil['Kelas']} · ${profil['Kampus']}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Identitas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            for (final d in profil.entries)
              BarisInfo(label: d.key, nilai: d.value),
            const SizedBox(height: 24),
            const Text(
              'Keahlian',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            for (final i in keahlian)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: warna.primary),
                    const SizedBox(width: 8),
                    Text(i),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

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
