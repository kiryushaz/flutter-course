import 'package:flutter/material.dart';
import 'package:flutter_course/src/theme/app_colors.dart';

class CategoryButton extends StatefulWidget {
  final String text;
  final bool isActive;
  final Function()? onPressed;

  const CategoryButton({super.key, required this.text, required this.isActive, this.onPressed});

  @override
  _CategoryButtonState createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: widget.isActive
                ? CoffeeAppColors.activeCategoryBackground
                : CoffeeAppColors.categoryBackground,
            foregroundColor: widget.isActive
                ? CoffeeAppColors.activeCategoryTextColor
                : CoffeeAppColors.categoryTextColor,
            minimumSize: Size.zero,
            textStyle: Theme.of(context).textTheme.bodyMedium,
            padding: const EdgeInsets.all(8.0)),
        onPressed: widget.onPressed,
        child: Text(widget.text));
  }
}
