import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import 'cart_screen.dart';


class ProductListScreen extends StatelessWidget {
  ProductListScreen({super.key});

  final List<Product> products = [
    Product(
      id: 'p1',
      name: 'Laptop',
      price: 1200,
      imageUrl: 'https://static.vecteezy.com/system/resources/previews/040/692/510/non_2x/ai-generated-tranquil-meadow-green-trees-sunset-sky-nature-serene-beauty-generated-by-ai-free-photo.jpg',
    ),
    Product(
      id: 'p2',
      name: 'Phone',
      price: 800,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      id: 'p3',
      name: 'Headphones',
      price: 150,
      imageUrl: 'https://static.vecteezy.com/system/resources/previews/040/692/510/non_2x/ai-generated-tranquil-meadow-green-trees-sunset-sky-nature-serene-beauty-generated-by-ai-free-photo.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Catalog'),
          actions: [
            Consumer<CartProvider>(
              builder: (ctx, cart, _) => Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    iconSize: 40,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CartScreen()),
                      );
                    },
                  ),
                  if (cart.totalItems > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          cart.totalItems.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: products.length,
        itemBuilder: (ctx, i) {
          return Card(
            elevation: 4,
            child: Column(
              children: [
                Image.network(
                  products[i].imageUrl,
                  height: 100,
                ),
                Text(
                  products[i].name,
                  style: const TextStyle(fontSize: 18),
                ),
                Text('\$${products[i].price}'),
                ElevatedButton(
                  onPressed: () {
                    cart.addItem(products[i]);
                  },
                  child: const Text('Add to Cart'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}