import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mainapp/models/CartProvider.dart';
import 'package:provider/provider.dart';
import 'package:mainapp/models/product.dart';

class ProductListPage extends StatelessWidget {
  final String category;

  ProductListPage({required this.category});

  @override
  Widget build(BuildContext context) {
    final products =
        Provider.of<ProductProvider>(context).products.values.where((product) {
      if (category == "Sport" && product is SportProduct) return true;
      if (category == "Clothes" && product is ClothesProduct) return true;
      if (category == "Shoes" && product is ShoesProduct) return true;
      return false;
    }).toList();

    // ignore: unused_local_variable
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("$category Products"),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          Product product = products[index];
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
                context.go('/product_detail', extra: {'product': product});
              },
            ),
          );
        },
      ),
    );
  }
}
