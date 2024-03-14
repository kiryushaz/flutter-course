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

  void selectCategory(index) {
    setState(() {
      if (index != _selectedIndex) {
        _selectedIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            height: 68.0,
            child: ListView.separated(
              padding: const EdgeInsets.all(16.0),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) => CategoryButton(
                  text: categories[index].name,
                  isActive: index == _selectedIndex,
                  onPressed: () => selectCategory(index)),
              separatorBuilder: (context, index) => const SizedBox(width: 8.0),
            ),
          ),
        ),
        // Expanded(
        //   child: ListView.builder(
        //     itemCount: categories.length,
        //     itemBuilder: (context, index) {
        //       return Text(categories[index].name, style: Theme.of(context).textTheme.titleLarge);
        //     },
        //   )
        // )
      ],
    ));
  }
}
