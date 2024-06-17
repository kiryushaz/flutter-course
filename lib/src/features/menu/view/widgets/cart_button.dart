import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_course/src/features/menu/bloc/menu_bloc.dart';
import 'package:flutter_course/src/theme/image_sources.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    final MenuBloc bloc = context.watch<MenuBloc>();
    final double totalCost = bloc.state.cartItems!.isEmpty
        ? 0.0
        : bloc.state.cartItems!
            .map<double>((e) => double.parse(e.prices[0].value))
            .reduce((value, element) => value + element);
    return Row(
      children: [
        ImageSources.cartIcon,
        const SizedBox(width: 10),
        Text('$totalCost RUB')
      ],
    );
  }
}
