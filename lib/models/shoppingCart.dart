import 'package:mainapp/models/product.dart';

class ShoppingCart {
  final Map<String, Product> _cart = {};
  final Map<String, int> _quantityPurchased = {}; 

  void addProduct(Product product, int quantity) {
    if (_cart.containsKey(product.name)) {
      _quantityPurchased[product.name] = (_quantityPurchased[product.name] ?? 0) + quantity;
    } else {
      _cart[product.name] = product;
      _quantityPurchased[product.name] = quantity;
    }
    _updateCart();
  }

  void removeProduct(String productName) {
    _cart.remove(productName);
    _quantityPurchased.remove(productName);
    _updateCart();
  }

  void clearCart() {
    _cart.clear();
    _quantityPurchased.clear();
    _updateCart();
  }

  void _updateCart() {
    calculateTotalPrice();
    totalItems;
  }

  double calculateTotalPrice() {
    double totalPrice = 0.0;
    _cart.forEach((key, product) {
      totalPrice += product.price * (_quantityPurchased[key] ?? 0); 
    });
    return totalPrice;
  }

  void displayCart() {
    if (_cart.isEmpty) {
      print("Shopping cart is empty.");
      return;
    }
    _cart.forEach((key, product) {
      print("Product: ${product.name}, Quantity Purchased: ${_quantityPurchased[key]}, Price: ${product.price}");
    });
  }

  int get totalItems {
    int total = 0;
    _quantityPurchased.forEach((key, quantity) {
      total += quantity;
    });
    return total;
  }

  double get totalPrice => calculateTotalPrice();

  List<Product> getProducts() {
    return _cart.values.toList();
  }

  List<int> getProductsQ() {
    return _quantityPurchased.values.toList();
  }

  int getQuantityPurchased(String productName) {
    return _quantityPurchased[productName] ?? 0;
  }
}
