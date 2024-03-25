import 'package:flutter/material.dart';
import 'package:flutter_course/src/features/menu/bloc/menu_bloc.dart';
import 'package:flutter_course/src/features/menu/model/product.dart';
import 'package:flutter_course/src/theme/app_colors.dart';

class Coffeecard extends StatefulWidget {
  final Product coffee;
  final MenuBloc bloc;
  final List<Product> cart;
  const Coffeecard({super.key, required this.bloc, required this.coffee, required this.cart});

  @override
  _CoffeecardState createState() => _CoffeecardState();
}

class _CoffeecardState extends State<Coffeecard> {
  int _count = 0;

  Widget changeCountPurchasedItems() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(32, 32),
                  textStyle: Theme.of(context).textTheme.bodySmall,
                  padding: const EdgeInsets.symmetric(vertical: 4.0)),
              onPressed: () {
                widget.bloc.add(const RemoveItemFromCartEvent());
                setState(() {
                  _count--;
                  widget.cart.remove(widget.coffee);
                });
              },
              child: const Text("-")),
          const SizedBox(width: 4),
      ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(52, 32),
              textStyle: Theme.of(context).textTheme.bodySmall,
              padding: const EdgeInsets.symmetric(vertical: 4.0)),
          onPressed: () {
            debugPrint(widget.cart.toString());
          },
          child: Text("$_count")),
      const SizedBox(width: 4),
      ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(32, 32),
              textStyle: Theme.of(context).textTheme.bodySmall,
              padding: const EdgeInsets.symmetric(vertical: 4.0)),
          onPressed: () {
            widget.bloc.add(const AddItemToCartEvent());
            setState(() {
              if (_count < 10) {
                _count++;
                widget.cart.add(widget.coffee);
              }
            });
          },
          child: const Text("+")),
        ],
      );
  }

  Widget showPurchaseButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(116, 32),
            elevation: 0,
            textStyle: Theme.of(context).textTheme.bodySmall,
            padding: const EdgeInsets.symmetric(vertical: 4.0)),
        onPressed: () {
          widget.bloc.add(const AddItemToCartEvent());
          setState(() {
            _count++;
            widget.cart.add(widget.coffee);
          });
        },
        child: Text(widget.coffee.prices[0].toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: ShapeDecoration(
          color: CoffeeAppColors.cardBackground,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
      child: Column(children: [
        widget.coffee.imageUrl != ''
            ? Image.network(widget.coffee.imageUrl, height: 100)
            : Image.asset('assets/images/nopicture.png'),
        Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: Text(widget.coffee.name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    fontSize: 16))),
        _count > 0 ? changeCountPurchasedItems() : showPurchaseButton()
      ]),
    );
  }
}
