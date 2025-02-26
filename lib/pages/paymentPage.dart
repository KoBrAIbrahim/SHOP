import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mainapp/models/CartProvider.dart';
import 'package:provider/provider.dart';
import 'package:mainapp/models/payment.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool isVisaSelected = false;
  bool isPaypalSelected = false;
  late double totalAmount;

  @override
  void initState() {
    super.initState();
    totalAmount = Provider.of<CartProvider>(context, listen: false).totalPrice;
  }

  void handlePayment() {
    final cart = Provider.of<CartProvider>(context, listen: false);
    if (isVisaSelected) {
      VisaPayment visaPayment = VisaPayment("1234-5678-9101-1121");
      visaPayment.pay(totalAmount);
    } else if (isPaypalSelected) {
      PayPalPayment paypalPayment = PayPalPayment("ibrahim@gmail.com");
      paypalPayment.pay(totalAmount);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please select a payment method.")));
      return;
    }

    cart.clearCart();
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Payment Page",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.home, size: 30),
            onPressed: () {
              context.go('/');
            },
          ),
        ],
      ),
      body: cart.cart.isEmpty
          ? Center(
              child: Text(
                "Your cart is empty",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart.cart.length,
                      itemBuilder: (context, index) {
                        var item = cart.cart.values.toList()[index];
                        var itemQ = cart.getQuantityPurchased(item.name);
                        return GestureDetector(
                          onDoubleTap: () {
                            setState(() {
                              cart.removeProduct(item.name);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text("${item.name} removed from cart")),
                            );
                          },
                          child: Card(
                            elevation: 5,
                            margin: EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  "assets/${item.name.toLowerCase()}.jpg",
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                item.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              subtitle: Text(
                                "Price: \$${item.price.toStringAsFixed(2)} | Quantity: $itemQ",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 28,
                                ),
                                onPressed: () {
                                  setState(() {
                                    cart.removeProduct(item.name);
                                  });
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      "Total Price: \$${cart.totalPrice.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  const Text(
                    "Choose Payment Method:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: isVisaSelected,
                        onChanged: (bool? value) {
                          setState(() {
                            isVisaSelected = value ?? false;
                            if (isVisaSelected) {
                              isPaypalSelected = false;
                            }
                          });
                        },
                      ),
                      Text("Visa"),
                      SizedBox(width: 16),
                      Checkbox(
                        value: isPaypalSelected,
                        onChanged: (bool? value) {
                          setState(() {
                            isPaypalSelected = value ?? false;
                            if (isPaypalSelected) {
                              isVisaSelected = false;
                            }
                          });
                        },
                      ),
                      Text("PayPal"),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: handlePayment,
                    child: Text("Proceed to Pay"),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      backgroundColor: Colors.blueAccent,
                      textStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
