import 'package:flutter/material.dart';
import 'package:flutter_course/src/features/menu/view/widgets/category_button.dart';
import 'package:flutter_course/src/features/menu/view/widgets/coffeecard.dart';
import '../data/category_data.dart';
import '../data/coffee_data.dart';
import '../model/coffee.dart';

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
      slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              elevation: 0,
              flexibleSpace: SizedBox(
                height: 36,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) => CategoryButton(
                      text: categories[index].name,
                      isActive: index == _selectedIndex,
                      onPressed: () => selectCategory(index)),
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8.0),
                ),
              ),
            )
          ] +
          categories
              .map((category) {
                List<Coffee> coffeeCat = coffee
                    .where((element) => element.category == category)
                    .toList();
                return [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    sliver: SliverToBoxAdapter(
                      child: Text(category.name,
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(16.0),
                    sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 250.0,
                          mainAxisExtent: 196,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: 1.0,
                        ),
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return Coffeecard(coffee: coffeeCat[index]);
                        }, childCount: coffeeCat.length)
                    ),
                  ),
                ];
              })
              .expand((element) => element)
              .toList(),
    ));
  }
}
