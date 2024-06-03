import 'package:flutter/material.dart';
import 'package:payment_new_app/Features/checkout/presentation/views/my_cart_view.dart';

void main() {
  runApp(const PaymentNewApp());
}

class PaymentNewApp extends StatelessWidget {
  const PaymentNewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyCartView(),
    );
  }
}