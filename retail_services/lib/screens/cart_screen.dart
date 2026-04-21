import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/product.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: cart.items.values.map((item) {
                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 5),
                  child: ListTile(
                    title: Text(item.name),
                    subtitle: Text(
                      'Price: \$${item.price} x ${item.quantity} = \$${(item.price * item.quantity).toStringAsFixed(2)}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            cart.decreaseItem(item.id);
                          },
                        ),
                        Text(item.quantity.toString()),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            cart.addItem(
                              // Dummy Product not needed; use CartItem info
                              Product(
                                id: item.id,
                                name: item.name,
                                price: item.price,
                                imageUrl: '',
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            cart.removeItem(item.id);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Total: \$${cart.totalAmount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}