import 'package:flutter/material.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, Product> _cart = {};
  final Map<String, int> _quantityPurchased = {}; 

  Map<String, Product> get cart => _cart;
  int get totalItems => _quantityPurchased.values.fold(0, (sum, qty) => sum + qty);
  double get totalPrice {
    return _cart.entries.fold(
      0.0,
      (sum, entry) => sum + (entry.value.price * (_quantityPurchased[entry.key] ?? 0)),
    );
  }

  void addProduct(Product product, int quantity) {
    if (_cart.containsKey(product.name)) {
      _quantityPurchased[product.name] = (_quantityPurchased[product.name] ?? 0) + quantity;
    } else {
      _cart[product.name] = product;
      _quantityPurchased[product.name] = quantity;
    }
    notifyListeners();
  }

  void removeProduct(String productName) {
    _cart.remove(productName);
    _quantityPurchased.remove(productName);
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    _quantityPurchased.clear();
    notifyListeners();
  }

  int getQuantityPurchased(String productName) {
    return _quantityPurchased[productName] ?? 0;
  }
}
