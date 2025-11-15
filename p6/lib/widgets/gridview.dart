import 'package:flutter/material.dart';
import 'package:p6/models/travel_model.dart';
import 'package:p6/widgets/detail_dialog.dart';

Widget gridview() {
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
      
      return GridView.builder(
        padding: EdgeInsets.all(10),
        itemCount: data.travelData.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7, 
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          final item = data.travelData[index];
          final title = item['title'] ?? "Index tidak ada";
          final description = item['description'] ?? 'Tidak ada deskripsi.';
          
          final snippet = description.length > 50 
            ? description.substring(0, 50) + '...' 
            : description;

          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                showDetailsDialog(title, description);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Image.network(
                      item['image'] ?? "https://placehold.co/300x200/CCCCCC/333333?text=No+Image",
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[300],
                        child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
                    child: Text(
                      snippet,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    }
  );
}