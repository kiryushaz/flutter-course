import 'package:flutter/material.dart';
import 'package:flutter_course/src/features/menu/view/widgets/category_button.dart';
import '../data/category_data.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 36.0,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) => CategoryButton(
                text: categories[index].name,
                isActive: index == _selectedIndex),
            separatorBuilder: (context, index) => const SizedBox(width: 8.0),
          ),
        )
      ],
    ));
  }
}
