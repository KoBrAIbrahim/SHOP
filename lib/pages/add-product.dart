import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  List<String> products = [];
  Map<int, Color> itemColors = {};
  TextEditingController nameController = TextEditingController();

  void addProduct(String name) {
    if (name.isNotEmpty) {
      setState(() {
        products.add(name);
      });
      nameController.clear();
    }
  }

  void removeProduct(int index) {
    setState(() {
      products.removeAt(index);
    });
  }

  void changeItemColor(int index) {
    setState(() {
      itemColors[index] =
          itemColors[index] == Colors.blue ? Colors.green : Colors.blue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Products'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              context.go('/');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Enter Product Name',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) {
                      addProduct(value);
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    addProduct(nameController.text);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onDoubleTap: () => changeItemColor(index),
                  onLongPress: () => removeProduct(index),
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 8,
                    color: itemColors[index] ?? Colors.white,
                    child: ListTile(
                      title: Text(
                        products[index],
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
