import 'package:flutter/material.dart';
import 'package:p8/theme_provider.dart';
import 'package:provider/provider.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    final TextEditingController nameController = TextEditingController(
      text: themeProvider.userName,
    );

    // Tentukan teks berdasarkan status dark mode
    final String themeText = themeProvider.isDarkMode
        ? 'Mode Gelap'
        : 'Mode Terang';

    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan untuk ${themeProvider.userName}'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- Pengaturan Nama Pengguna ---
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Masukkan Nama Pengguna',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                themeProvider.setUserName(nameController.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Nama pengguna tersimpan!')),
                );
              },
              child: const Text('Simpan Nama Pengguna'),
            ),

            const SizedBox(height: 30),

            // --- Pengaturan Mode Tema ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Menggunakan variabel themeText yang dinamis
                Text(themeText, style: const TextStyle(fontSize: 20)),
                Switch(
                  value: themeProvider.isDarkMode,
                  onChanged: (value) {
                    Provider.of<ThemeProvider>(
                      context,
                      listen: false,
                    ).toggleTheme(value);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
