import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productName;

  // Properti Produk yang akan dicari berdasarkan productName
  // Kunci (Key) adalah Nama Produk (String), Nilai (Value) adalah Map yang berisi Merk dan Image URL
  final Map<String, Map<String, String>> productData = {
    "Smartphone": {
      "brand": "Samsung",
      "image_url": "https://images.unsplash.com/photo-1593642632823-8f785ba67e45?fit=crop&w=400&q=80"
    },
    "Laptop": {
      "brand": "HP",
      "image_url": "https://m.media-amazon.com/images/S/aplus-media/vc/779be7f4-dbad-458a-bc30-f793cd214059.jpg"
    },
    "Tablet": {
      "brand": "Xiaomi",
      "image_url": "https://tse1.mm.bing.net/th/id/OIP.J5vTL2MzNYCKxW29iXhsMAHaFF?rs=1&pid=ImgDetMain&o=7&rm=3"
    },
    "Smartwatch": {
      "brand": "Garmin",
      "image_url": "https://i5.walmartimages.com/asr/1a97d940-2a3d-4b0a-b9a6-1dc1fcab1a22.4e662b6e0836595c09dcf22a734f285c.jpeg?odnWidth=1000&odnHeight=1000&odnBg=ffffff"
    },
    "Headphones": {
      "brand": "Sony",
      "image_url": "https://m.media-amazon.com/images/I/51rpbVmi9XL._SL1200_.jpg"
    },
  };

   ProductDetailScreen({
    super.key,
    required this.productName, // Hanya menerima nama produk
  });

  @override
  Widget build(BuildContext context) {
    // 1. Ambil data spesifik berdasarkan productName
    final productInfo = productData[productName];

    // Cek apakah data produk ditemukan
    if (productInfo == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: const Center(
          child: Text("Data produk tidak ditemukan."),
        ),
      );
    }

    // Ambil nilai Merk dan URL Gambar yang sudah pasti ada
    final String productBrand = productInfo["brand"]!;
    final String productImageUrl = productInfo["image_url"]!;

    return Scaffold(
      appBar: AppBar(
        title: Text(productName),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Tampilan Gambar
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                productImageUrl,
                height: 250,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 250,
                    color: Colors.grey[200],
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 250,
                    color: Colors.red[50],
                    child: const Center(
                      child: Icon(Icons.error, color: Colors.red, size: 50),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),

            // Tampilan Nama Produk
            Text(
              productName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const Divider(height: 20, thickness: 2),

            // Tampilan Merek Produk
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.verified, color: Colors.blue, size: 24),
                const SizedBox(width: 8),
                Text(
                  "Merek: $productBrand",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Deskripsi Statis
            const Text(
              "Deskripsi Produk:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Produk ini menawarkan kombinasi sempurna antara desain modern dan performa tinggi. Detail yang Anda lihat (merk dan gambar) didapatkan secara internal dari data yang tersimpan di halaman ini berdasarkan nama produk yang Anda klik.",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}