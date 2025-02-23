import 'package:flutter/material.dart';
import 'package:mainapp/models/shoppingCart.dart';
import 'package:mainapp/pages/ProductDetailPage.dart';
import '../models/product.dart';

class ProductListPage extends StatelessWidget {
  final String category;
  final Map<String, Product> products;
  final ShoppingCart cart;

  ProductListPage({required this.category, required this.products , required this.cart});

  @override
  Widget build(BuildContext context) {
    List<Product> filteredProducts = products.values.where((product) {
      if (category == "Sport" && product is SportProduct) return true;
      if (category == "Clothes" && product is ClothesProduct) return true;
      if (category == "Shoes" && product is ShoesProduct) return true;
      return false;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("$category Products"),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: filteredProducts.length,
        itemBuilder: (context, index) {
          Product product = filteredProducts[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 5,
            child: ListTile(
              title: Text(
                product.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                "\$${product.price.toStringAsFixed(2)} | Quantity: ${product.quantity}",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              leading: const Icon(
                Icons.shopping_cart,
                color: Colors.blue,
                size: 30,
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.blue,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailPage(product: product,cart: cart,),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
