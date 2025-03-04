import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> categories = [
    {
      "title": "Sport",
      "subtitle": "Explore the best sport products",
      "icon": Icons.sports_soccer
    },
    {
      "title": "Clothes",
      "subtitle": "Trendy and comfortable clothes",
      "icon": Icons.checkroom
    },
    {
      "title": "Shoes",
      "subtitle": "Stylish shoes for every occasion",
      "icon": Icons.directions_run
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text("Welcome to Shop",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () => context.go('/payment')),
          IconButton(
              icon: Icon(Icons.add_box),
              onPressed: () => context.go('/add-product')),
          IconButton(
              icon: Icon(Icons.view_agenda),
              onPressed: () => context.go('/fetch-data')),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              context.go('/admin-list');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20.0),
          Container(
            width: MediaQuery.of(context).size.width - 100,
            height: 300,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/shop.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
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

  Widget _buildCategoryTile(
      BuildContext context, String title, String subtitle, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 8,
      child: ListTile(
        leading: Icon(icon, color: Colors.blue, size: 30),
        title: Text(title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[600])),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.blue),
        onTap: () => context.go('/product-list/$title'),
      ),
    );
  }
}
