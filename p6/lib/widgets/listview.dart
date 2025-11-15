import 'package:flutter/material.dart';
import 'package:p6/models/travel_model.dart';
import 'package:p6/screens/detail_screen.dart';

Widget listview() {
  Travel data = Travel();

  return Builder(
    builder: (context) {
      return ListView.builder(
        itemCount: data.travelData.length,
        itemBuilder: (context, index) {
          final item = data.travelData[index];
          final title = item['title'] ?? 'Tidak ada Judul';
          final description = item['description'] ?? 'Tidak ada deskripsi.';
          final imageUrl =
              item['image'] ??
              'https://placehold.co/100x100/CCCCCC/333333?text=No+Image';

          final subtitleText = description.length > 100
              ? description.substring(0, 100) + '...'
              : description;

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Hero(
                  tag: 'travelImage-$title',
                  child: Image.network(
                    imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image),
                    ),
                  ),
                ),
              ),
              title: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(subtitleText),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      title: title,
                      description: description,
                      imageUrl: imageUrl,
                    ),
                  ),
                );
              },
            ),
          );
        },
      );
    },
  );
}
