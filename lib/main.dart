import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mainapp/models/shoppingCart.dart';
import 'package:mainapp/pages/ProductDetailPage.dart';
import 'package:mainapp/pages/paymentPage.dart';
import 'models/product.dart';
import 'pages/home_page.dart';
import 'pages/product_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Map<String, Product> _initializeProducts() {
    final Map<String, Product> products = {
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
    return products;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, Product> products = _initializeProducts();
    final ShoppingCart cart = ShoppingCart();
    final GoRouter router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            return HomePage(
              products: products,
              cart: cart,
            );
          },
        ),
        GoRoute(
          path: '/product-list/:category',
          builder: (context, state) {
            String category = state.params['category'] ?? '';
            return ProductListPage(
              category: category,
              products: products,
              cart: cart,
            );
          },
        ),
        GoRoute(
          path: '/product_detail',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            final Product product = extra?['product'];
            final ShoppingCart cart = extra?['cart'];
         
            return ProductDetailPage(
              product: product,
              cart: cart,
            );
          },
        ),
        GoRoute(
          path: '/payment',
          builder: (context, state) {
            final cart = state.extra as ShoppingCart;
            return PaymentPage(cart: cart);
          },
        ),
      ],
    );

    return MaterialApp.router(
      title: 'Product App',
      routerConfig: router,
    );
  }
}
