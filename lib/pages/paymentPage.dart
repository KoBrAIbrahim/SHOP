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
  double _opacity = 0.0;
  bool _showPaymentOptions = false;

  @override
  void initState() {
    super.initState();
    totalAmount = Provider.of<CartProvider>(context, listen: false).totalPrice;
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
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
      body: AnimatedOpacity(
        duration: Duration(milliseconds: 700),
        opacity: _opacity,
        child: cart.cart.isEmpty
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
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _showPaymentOptions = !_showPaymentOptions;
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.3),
                              blurRadius: _showPaymentOptions ? 10 : 5,
                              spreadRadius: _showPaymentOptions ? 3 : 1,
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.payment,
                              color: Colors.blue,
                              size: 30,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              _showPaymentOptions
                                  ? "Select Payment Method"
                                  : "Open to Select Payment Method",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      height: _showPaymentOptions ? 60 : 0,
                      child: Visibility(
                        visible: _showPaymentOptions,
                        child: Row(
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
                      ),
                    ),
                    ElevatedButton(
                      onPressed: handlePayment,
                      child: Text("Proceed to Pay"),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 15, horizontal: 30),
                        backgroundColor: Colors.blueAccent,
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
