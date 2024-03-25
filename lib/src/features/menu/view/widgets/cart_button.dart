import 'package:flutter/material.dart';

class CartButton extends StatelessWidget {
  final Map<String, int> cart;
  
  const CartButton({
    super.key, required this.cart,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(Icons.shopping_basket_outlined),
        SizedBox(width: 10),
        Text('0')
      ],
    );
  }
}
