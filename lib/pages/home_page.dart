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

  double opacityLevel = 0.0;
  int? expandedIndex; 

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        opacityLevel = 1.0;
      });
    });
  }

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
          AnimatedOpacity(
            duration: Duration(seconds: 1),
            opacity: opacityLevel,
            child: Container(
              width: MediaQuery.of(context).size.width - 100,
              height: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/shop.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Expanded(
            child: AnimatedOpacity(
              duration: Duration(seconds: 1),
              opacity: opacityLevel,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return _buildCategoryTile(
                    context,
                    categories[index]["title"],
                    categories[index]["subtitle"],
                    categories[index]["icon"],
                    index,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTile(
      BuildContext context, String title, String subtitle, IconData icon, int index) {
    bool isExpanded = expandedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          expandedIndex = (expandedIndex == index) ? null : index;
        });
        Future.delayed(Duration(milliseconds: 1200), () {
          context.go('/product-list/$title');
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: EdgeInsets.all(isExpanded ? 20 : 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.3),
              blurRadius: isExpanded ? 12 : 6,
              spreadRadius: isExpanded ? 2 : 1,
            )
          ],
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.blue, size: isExpanded ? 40 : 30),
          title: Text(title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[600])),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.blue,
            size: isExpanded ? 25 : 20,
          ),
        ),
      ),
    );
  }
}
