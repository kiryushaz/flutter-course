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
        Image.asset(widget.coffee.image ?? 'images/nopicture.png',
            height: 100),
        Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(widget.coffee.name,
                style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    fontSize: 16))),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          if (_count > 0) ...[
            InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                setState(() {
                  _count--;
                });
              },
              child: Container(
                width: 24,
                height: 24,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(4.0),
                decoration: ShapeDecoration(
                    color: CoffeeAppColors.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16))),
                child: const Text("–",
                    style: TextStyle(fontSize: 12, color: Colors.white)),
              ),
            ),
            const Spacer(),
            Container(
              width: 52,
              height: 24,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(4.0),
              decoration: ShapeDecoration(
                  color: const Color(0xFF85C3DE),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16))),
              child: Text("$_count",
                  style: const TextStyle(fontSize: 12, color: Colors.white)),
            ),
            const Spacer(),
            InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                setState(() {
                  if (_count < 10) _count++;
                });
              },
              child: Container(
                width: 24,
                height: 24,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(4.0),
                decoration: ShapeDecoration(
                    color: const Color(0xFF85C3DE),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16))),
                child: const Text("+",
                    style: TextStyle(fontSize: 12, color: Colors.white)),
              ),
            )
          ] else ...[
            InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                setState(() {
                  _count++;
                });
              },
              child: Container(
                width: 116,
                height: 24,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(4.0),
                decoration: ShapeDecoration(
                    color: const Color(0xFF85C3DE),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16))),
                child: Text("${widget.coffee.price} руб",
                    style: const TextStyle(fontSize: 12, color: Colors.white)),
              ),
            )
          ]
        ])
      ]),
    );
  }
}
