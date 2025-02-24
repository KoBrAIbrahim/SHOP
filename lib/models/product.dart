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
  ShoesProduct(String name, double price, int quantity , this.size)
      : super(name, price, quantity);

  @override
  void displayInfo() {
    print(
        "Shoes Product: $name - \$${price.toStringAsFixed(2)}, Quantity: $quantity");
  }
}
