import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mainapp/models/CartProvider.dart';
import 'package:provider/provider.dart';
import 'package:mainapp/models/product.dart';
import 'package:mainapp/pages/home_page.dart';
import 'package:mainapp/pages/product_list_page.dart';
import 'package:mainapp/pages/ProductDetailPage.dart';
import 'package:mainapp/pages/add-product.dart';
import 'package:mainapp/pages/paymentPage.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      initialLocation: '/',  
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            return HomePage();
          },
        ),
        GoRoute(
          path: '/product-list/:category',
          builder: (context, state) {
            String category = state.params['category'] ?? '';
            return ProductListPage(
              category: category,
            );
          },
        ),
        GoRoute(
          path: '/product_detail',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;  
            final Product product = extra?['product'];
            return ProductDetailPage(product: product);
          },
        ),
        GoRoute(
          path: '/payment',
          builder: (context, state) {
            return PaymentPage();
          },
        ),
        GoRoute(
          path: '/add-product',  
          builder: (context, state) {
            return AddProductPage();  
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