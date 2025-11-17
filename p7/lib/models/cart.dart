import 'package:flutter/material.dart';
import 'package:p7/models/product.dart';

class Cart extends ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => _items;

  int get totalItems => _items.length;

  double get totalPrice {
    double total = 0;
    for (var item in _items) {
      total += item.price; 
    }
    return total;
  }

  void addItem(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void removeItem(Product product) {
    _items.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
