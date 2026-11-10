import 'package:flutter/material.dart';
import '../main.dart';
import 'sapa_page.dart'; // Import halaman SapaPage

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Akademik'),
        backgroundColor: warna.primaryContainer,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TambahMahasiswaPage()),
          );
        },
        icon: const Icon(Icons.person_add),
        label: const Text('Tambah'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 88),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profil Saya'),
              subtitle: const Text('Identitas dan keahlian'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilPage()),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.handshake),
              title: const Text('Sapa User'),
              subtitle: const Text('Demo interaksi input sederhana'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SapaPage()),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Daftar Mahasiswa',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          for (final mhs in daftarMahasiswa)
            Card(
              child: ListTile(
                leading: CircleAvatar(child: Text(mhs['nama']![0])),
                title: Text(mhs['nama']!),
                subtitle: Text('NIM ${mhs['nim']}'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailMahasiswaPage(mahasiswa: mhs),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
