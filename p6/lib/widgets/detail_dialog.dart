import 'package:flutter/material.dart';

class DetailDialog extends StatelessWidget {
  final String title;
  final String description;

  const DetailDialog({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // Memberikan bentuk yang lebih modern pada dialog
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Divider(),
            // Menampilkan deskripsi lengkap
            Text(description, textAlign: TextAlign.justify),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Tutup', style: TextStyle(fontWeight: FontWeight.bold)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}