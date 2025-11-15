import 'package:flutter/material.dart';
import 'package:p6/widgets/gridview.dart';
import 'package:p6/widgets/listview.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Katalog Wisata',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.list), text: 'ListView'),
              Tab(icon: Icon(Icons.grid_on), text: 'GridView'),
            ],
          ),
        ),
        body: TabBarView(children: [listview(), gridview()]),
      ),
    );
  }
}
