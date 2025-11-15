import 'package:flutter/material.dart';
import 'package:p6/models/travel_model.dart';
import 'package:p6/widgets/detail_dialog.dart'; 

Widget listview() {
  Travel data = Travel();
  return Builder(
    builder: (context) {
      void showDetailsDialog(String title, String description) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return DetailDialog(title: title, description: description);
          },
        );
      }

      return ListView.builder(
        itemCount: data.travelData.length,
        itemBuilder: (context, index) {
          final item = data.travelData[index];
          final title = item['title'] ?? 'Tidak ada Judul';
          final description = item['description'] ?? 'Tidak ada deskripsi.';
          
          final subtitleText = description.length > 100 
            ? description.substring(0, 100) + '...' 
            : description;

          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              contentPadding: EdgeInsets.all(10),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  item['image'] ?? 'https://placehold.co/100x100/CCCCCC/333333?text=No+Image',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 80, height: 80, color: Colors.grey[300], child: Icon(Icons.broken_image)),
                ),
              ),
              title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(subtitleText), 
              onTap: () {
                showDetailsDialog(title, description);
              },
            ),
          );
        },
      );
    }
  );
}