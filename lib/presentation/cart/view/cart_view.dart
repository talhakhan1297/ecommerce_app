import 'package:flutter/material.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  static String route = '/cart';

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Cart'));
  }
}
