import 'package:flutter/material.dart';
import 'package:mainapp/models/shoppingCart.dart';
import 'package:mainapp/models/payment.dart';
import 'package:go_router/go_router.dart';

class PaymentPage extends StatefulWidget {
  final ShoppingCart cart;

  PaymentPage({required this.cart});

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
    totalAmount = widget.cart.totalPrice;
  }

  void handlePayment() {
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

    widget.cart.clearCart();

    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
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
      body: widget.cart.getProducts().isEmpty
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
                  Flexible(
                    child: ListView.builder(
                      itemCount: widget.cart.getProducts().length,
                      itemBuilder: (context, index) {
                        var item = widget.cart.getProducts()[index];
                        var itemQ = widget.cart.getProductsQ()[index];
                        return Card(
                          elevation: 5,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
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
                                  widget.cart.removeProduct(item.name);
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      "Total Price: \$${widget.cart.totalPrice.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Text(
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
