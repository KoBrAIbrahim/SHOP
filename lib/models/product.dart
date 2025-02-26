import 'package:flutter/material.dart';

abstract class Product {
  String name;
  double price;
  int quantity;

  Product(this.name, this.price, this.quantity);

  void displayInfo();
}

class SportProduct extends Product {
  String type;
  SportProduct(String name, double price, int quantity, this.type)
      : super(name, price, quantity);

  @override
  void displayInfo() {
    print(
        "Sport Product: $name - \$${price.toStringAsFixed(2)}, Quantity: $quantity");
  }
}

class ClothesProduct extends Product {
  String size;
  ClothesProduct(String name, double price, int quantity, this.size)
      : super(name, price, quantity);

  @override
  void displayInfo() {
    print(
        "Clothes Product: $name - \$${price.toStringAsFixed(2)}, Quantity: $quantity");
  }
}

class ShoesProduct extends Product {
  String size;
  ShoesProduct(String name, double price, int quantity, this.size)
      : super(name, price, quantity);

  @override
  void displayInfo() {
    print(
        "Shoes Product: $name - \$${price.toStringAsFixed(2)}, Quantity: $quantity");
  }
}

class ProductProvider extends ChangeNotifier {
  final Map<String, Product> _products = {
    '1': SportProduct("Football", 50.0, 10, 'Football'),
    '2': SportProduct("Basketball", 40.0, 15, 'Basketball'),
    '3': SportProduct("Tennis Racket", 80.0, 5, 'Tennis'),
    '4': SportProduct("Gym Dumbbells", 60.0, 8, 'Fitness'),
    '5': SportProduct("Boxing Gloves", 30.0, 12, 'Fitness'),
    '6': ClothesProduct("T-Shirt", 20.0, 5, 'XL'),
    '7': ClothesProduct("Jeans", 45.0, 7, '38'),
    '8': ClothesProduct("Jacket", 70.0, 4, 'XXL'),
    '9': ClothesProduct("Sweater", 35.0, 6, 'XL'),
    '10': ClothesProduct("Shorts", 25.0, 10, '32'),
    '11': ShoesProduct("Running Shoes", 80.0, 3, '42'),
    '12': ShoesProduct("Casual Sneakers", 65.0, 8, '43'),
    '13': ShoesProduct("Formal Shoes", 90.0, 2, '43'),
    '14': ShoesProduct("Boots", 100.0, 5, '44'),
    '15': ShoesProduct("Sandals", 30.0, 7, '40'),
  };

  Map<String, Product> get products => _products;

  void addProduct(String id, Product product) {
    _products[id] = product;
    notifyListeners();
  }

  void removeProduct(String id) {
    _products.remove(id);
    notifyListeners();
  }
}
