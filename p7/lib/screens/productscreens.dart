import 'package:flutter/material.dart';
import 'package:p7/models/cart.dart';
import 'package:p7/models/product.dart';
import 'package:p7/screens/cartscreens.dart'; 
import 'package:provider/provider.dart';

class ProductScreens extends StatelessWidget {
  const ProductScreens({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> products = [
      Product('Topi', 50000),
      Product('Kaos', 100000),
      Product('Celana', 120000),
      Product('Sepatu', 200000),
      Product('Jaket', 150000),
      Product('Anting', 40000),
      Product('Gelang', 25000),
      Product('Jam', 250000),
      Product('Rompi', 175000),
      Product('Kemeja', 160000),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Produk'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Consumer<Cart>(
              builder: (context, cart, child) {
                return Badge(
                  label: Text('${cart.totalItems}'),
                  isLabelVisible: cart.totalItems > 0,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.shopping_cart),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].nama),
            subtitle: Text('Rp${products[index].price}'),
            trailing: IconButton(
              icon: const Icon(Icons.add_shopping_cart),
              onPressed: () {
                Provider.of<Cart>(context, listen: false)
                    .addItem(products[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
