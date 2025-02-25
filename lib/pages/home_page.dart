import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mainapp/models/product.dart';
import 'package:mainapp/models/shoppingCart.dart';

class HomePage extends StatelessWidget {
  final Map<String, Product> products;
  final ShoppingCart cart;

  HomePage({required this.products, required this.cart});

  final List<Map<String, dynamic>> categories = [
    {"title": "Sport", "subtitle": "Explore the best sport products", "icon": Icons.sports_soccer},
    {"title": "Clothes", "subtitle": "Trendy and comfortable clothes", "icon": Icons.checkroom},
    {"title": "Shoes", "subtitle": "Stylish shoes for every occasion", "icon": Icons.directions_run},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LayoutBuilder(
          builder: (context, constraints) {
            double fontSize = 22;
            if (constraints.maxWidth < 400) {
              fontSize = 18;
            } else if (constraints.maxWidth >= 400 && constraints.maxWidth < 800) {
              fontSize = 22;
            } else {
              fontSize = 26;
            }
            return Text(
              "Welcome to Shop",
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            );
          },
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              context.go('/payment', extra: cart);
            },
          ),
          IconButton(
            icon: Icon(Icons.add_box),
            onPressed: () {
              context.go('/add-product');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 50.0),
          Container(
            width: MediaQuery.of(context).size.width - 100,
            height: 250,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/shop.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 50.0),
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return _buildCategoryTile(
                  context,
                  categories[index]["title"],
                  categories[index]["subtitle"],
                  categories[index]["icon"],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTile(BuildContext context, String title, String subtitle, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 8,
      child: ListTile(
        leading: Icon(icon, color: Colors.blue, size: 30),
        title: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[600])),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.blue),
        onTap: () {
          context.go('/product-list/$title');
        },
      ),
    );
  }
}
