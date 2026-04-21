
import 'package:flutter/foundation.dart';
import 'product.dart';

class Cart with ChangeNotifier {
  final Map<String, Product> _items = {};

  Map<String, Product> get items => {..._items};

  int get itemCount => _items.length;

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, product) {
      total += product.price;
    });
    return total;
  }

  void addItem(Product product) {
    _items[product.id] = product;
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
