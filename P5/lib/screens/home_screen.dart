import 'package:flutter/material.dart';
import 'detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // ... (Bagian atas kode HomeScreen tetap sama)

  @override
  Widget build(BuildContext context) {
    final List<String> products = [
      "Smartphone",
      "Laptop",
      "Tablet",
      "Smartwatch",
      "Headphones",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Produk Kami"),
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final String selectedProduct = products[index]; // Ambil nama produk

          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              title: Text(
                selectedProduct,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Klik untuk detail"),
              leading: const Icon(Icons.shopping_bag),
              // PENTING: Mengubah aksi onTap untuk melakukan navigasi
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(
                      // Mengirim nama produk ke halaman detail
                      productName: selectedProduct, 
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}