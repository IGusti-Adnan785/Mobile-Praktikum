import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda Aplikasi'),
        actions: [
          // 3. Tombol Logout
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Keluar',
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              // AuthWrapper di main.dart akan otomatis mendeteksi logout
              // dan mengembalikan user ke LoginPage
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 80, color: Colors.blue),
            const SizedBox(height: 20),
            Text('Halo, ${user?.email}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            const Text('Anda berhasil login!'),
          ],
        ),
      ),
    );
  }
}
