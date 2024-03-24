import 'package:flutter/material.dart';
import 'package:flutter_course/src/features/menu/model/product.dart';
import 'package:flutter_course/src/theme/app_colors.dart';

class Coffeecard extends StatefulWidget {
  final Product coffee;
  const Coffeecard({super.key, required this.coffee});

  @override
  _CoffeecardState createState() => _CoffeecardState();
}

class _CoffeecardState extends State<Coffeecard> {
  int _count = 0;

  List<Widget> changeCountPurchasedItems() {
    return [
      ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: CoffeeAppColors.primary,
              foregroundColor: CoffeeAppColors.secondaryTextColor,
              minimumSize: const Size(32, 32),
              textStyle: Theme.of(context).textTheme.bodySmall,
              padding: const EdgeInsets.symmetric(vertical: 4.0)),
          onPressed: () {
            setState(() {
              _count--;
            });
          },
          child: const Text("-")),
      const SizedBox(width: 4),
      ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: CoffeeAppColors.primary,
              foregroundColor: CoffeeAppColors.secondaryTextColor,
              minimumSize: const Size(52, 32),
              textStyle: Theme.of(context).textTheme.bodySmall,
              padding: const EdgeInsets.symmetric(vertical: 4.0)),
          onPressed: () {},
          child: Text("$_count")),
      const SizedBox(width: 4),
      ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: CoffeeAppColors.primary,
              foregroundColor: CoffeeAppColors.secondaryTextColor,
              minimumSize: const Size(32, 32),
              textStyle: Theme.of(context).textTheme.bodySmall,
              padding: const EdgeInsets.symmetric(vertical: 4.0)),
          onPressed: () {
            setState(() {
              if (_count < 10) _count++;
            });
          },
          child: const Text("+")),
    ];
  }

  Widget showPurchaseButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: CoffeeAppColors.primary,
            foregroundColor: CoffeeAppColors.secondaryTextColor,
            minimumSize: const Size(116, 32),
            elevation: 0,
            textStyle: Theme.of(context).textTheme.bodySmall,
            padding: const EdgeInsets.symmetric(vertical: 4.0)),
        onPressed: () {
          setState(() {
            _count++;
          });
        },
        child: Text(
            '${widget.coffee.prices[0].value} ${widget.coffee.prices[0].currency}'));
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
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          if (_count > 0)
            ...[changeCountPurchasedItems()].expand((element) => element)
          else
            showPurchaseButton()
        ])
      ]),
    );
  }
}
