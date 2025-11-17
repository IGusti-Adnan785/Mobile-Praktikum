import 'package:flutter/material.dart';
import 'package:p7/models/cart.dart';
import 'package:p7/screens/productscreens.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create:(context) => Cart(),
      child: const MaterialApp(
        title: 'product',
        home: ProductScreens(),
        debugShowCheckedModeBanner: false,
      )
    )
  );
}