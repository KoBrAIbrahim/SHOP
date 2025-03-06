import 'package:flutter/material.dart';

abstract class Payment {
  void pay(double amount);
}

class PaymentProvider extends ChangeNotifier {
  void processPayment(Payment paymentMethod, double amount) {
    paymentMethod.pay(amount);
    notifyListeners();
  }
}

class PayPalPayment implements Payment {
  String email;
  PayPalPayment(this.email);

  @override
  void pay(double amount) {
    print("Paid \$${amount.toStringAsFixed(2)} using PayPal (Email: $email).");
  }
}

class VisaPayment implements Payment {
  String cardNumber;
  VisaPayment(this.cardNumber);

  @override
  void pay(double amount) {
    print("Paid \$${amount.toStringAsFixed(2)} using Visa (Card: $cardNumber).");
  }
}
