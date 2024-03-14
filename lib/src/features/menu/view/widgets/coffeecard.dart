import 'package:flutter/material.dart';
import 'package:flutter_course/src/theme/app_colors.dart';
import '../../data/coffee_data.dart';
import '../../model/coffee.dart';

class Coffeecard extends StatefulWidget {
  final Coffee coffee;
  const Coffeecard({super.key, required this.coffee});

  @override
  _CoffeecardState createState() => _CoffeecardState();
}

class _CoffeecardState extends State<Coffeecard> {
  int _count = 0;

  Widget showPurchaseButton() {
    return ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: CoffeeAppColors.primary,
                foregroundColor: CoffeeAppColors.secondaryTextColor,
                minimumSize: const Size(116, 32),
                textStyle: Theme.of(context).textTheme.bodySmall,
                padding: const EdgeInsets.symmetric(vertical: 4.0)),
            onPressed: () {},
            child: Text("${widget.coffee.price} руб"));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      decoration: ShapeDecoration(
          color: CoffeeAppColors.cardBackground,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
      child: Column(children: [
        Image.asset(widget.coffee.image ?? 'images/nopicture.png', height: 100),
        Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(widget.coffee.name,
                style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    fontSize: 16))),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          if (_count > 0) ...[

          ] else ...[
            showPurchaseButton()
          ]
        ])
      ]),
    );
  }
}
