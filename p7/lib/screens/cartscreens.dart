import 'package:flutter/material.dart';
import 'package:p7/models/cart.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
      ),
      body: cart.items.isEmpty
          ? const Center(
              child: Text('Keranjang masih kosong'),
            )
          : ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                final item = cart.items[index];
                return ListTile(
                  leading: const Icon(Icons.shopping_bag),
                  title: Text(item.nama),
                  subtitle: Text('Rp${item.price}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      cart.removeItem(item);
                    },
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.grey.shade200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: Rp${cart.totalPrice}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                cart.clearCart();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Checkout berhasil!')),
                );
              },
              child: const Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
