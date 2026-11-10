import 'package:flutter/material.dart';

class SapaPage extends StatefulWidget {
  const SapaPage({super.key});

  @override
  State<SapaPage> createState() => _SapaPageState();
}

class _SapaPageState extends State<SapaPage> {
  final _namaController = TextEditingController();
  String _pesanSapaan = '';

  @override
  void dispose() {
    _namaController.dispose();
    super.dispose();
  }

  void _sapaUser() {
    setState(() {
      final nama = _namaController.text.trim();
      if (nama.isEmpty) {
        _pesanSapaan = 'Halo! Silakan masukkan nama Anda.';
      } else {
        _pesanSapaan = 'Halo, $nama! Selamat datang di Aplikasi Akademik.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo Sapa User'),
        backgroundColor: warna.primaryContainer,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _namaController,
              decoration: const InputDecoration(
                labelText: 'Masukkan Nama Anda',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.handshake),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _sapaUser,
              icon: const Icon(Icons.sentiment_satisfied_alt),
              label: const Text('Sapa Saya'),
            ),
            const SizedBox(height: 24),
            if (_pesanSapaan.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: warna.secondaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _pesanSapaan,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
