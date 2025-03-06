import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mainapp/models/CartProvider.dart';
import 'package:provider/provider.dart';
import 'package:mainapp/models/product.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  ProductDetailPage({required this.product});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late int _quantity;
  final TransformationController _controller = TransformationController();
  double _scale = 1.0;
  Offset _tapPosition = Offset.zero;
  bool _imageExpanded = false;
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _quantity = 1;
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  void _handleDoubleTap(TapDownDetails details) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset localPosition =
        renderBox.globalToLocal(details.globalPosition);

    setState(() {
      if (_scale == 1.0) {
        _scale = 2;
        _tapPosition = localPosition;
        _controller.value = Matrix4.identity()
          ..translate(
              -_tapPosition.dx * (_scale - 1), -_tapPosition.dy * (_scale - 1))
          ..scale(_scale);
      } else {
        _scale = 1.0;
        _controller.value = Matrix4.identity();
      }
    });
  }

  void _handleLongPress() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: InteractiveViewer(
          child: Image.asset(
            "assets/${widget.product.name.toLowerCase()}.jpg",
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  void _handleSingleTap() {
    setState(() {
      _imageExpanded = !_imageExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => context.go('/'),
          ),
        ],
      ),
      body: AnimatedOpacity(
        duration: Duration(milliseconds: 700),
        opacity: _opacity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onDoubleTapDown: _handleDoubleTap,
                onLongPress: _handleLongPress,
                onTap: _handleSingleTap,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  width: MediaQuery.of(context).size.width - 50,
                  height: _imageExpanded ? 350 : 250,
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: InteractiveViewer(
                    transformationController: _controller,
                    child: Image.asset(
                      "assets/${widget.product.name.toLowerCase()}.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Price: \$${widget.product.price.toStringAsFixed(2)}",
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "Quantity available: ${widget.product.quantity}",
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      setState(() {
                        if (_quantity > 1) _quantity--;
                      });
                    },
                  ),
                  Text(
                    "$_quantity",
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () {
                      setState(() {
                        if (_quantity < widget.product.quantity) _quantity++;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 100,
                  child: ElevatedButton(
                    onPressed: () {
                      cart.addProduct(widget.product, _quantity);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text("${widget.product.name} added to cart")),
                      );
                      context.go('/');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      textStyle: const TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("Add to Cart"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
