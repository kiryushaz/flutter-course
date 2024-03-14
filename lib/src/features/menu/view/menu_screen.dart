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
  final _scrollController = ScrollController();
  int _selectedIndex = 0;

  @override
  void initState() {
    _scrollController.addListener(() {
      print(_scrollController.offset);
    });
    super.initState();
  }

  void scrollTo(index) {
    setState(() {
      final targetContext = categories[index].key.currentContext;
      if (targetContext != null) {
        Scrollable.ensureVisible(targetContext,
            duration: const Duration(milliseconds: 500), curve: Curves.ease);
      }
    });
  }

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
      controller: _scrollController,
      slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              elevation: 0,
              shadowColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              flexibleSpace: SizedBox(
                height: 52,
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) => CategoryButton(
                      text: categories[index].name,
                      isActive: index == _selectedIndex,
                      onPressed: () {
                        selectCategory(index);
                        scrollTo(index);
                      }),
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
                      key: category.key,
                      child: Text(category.name,
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(16.0),
                    sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 320,
                          mainAxisExtent: 216,
                          mainAxisSpacing: 16.0,
                          crossAxisSpacing: 16.0,
                        ),
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return Coffeecard(coffee: coffeeCat[index]);
                        }, childCount: coffeeCat.length)),
                  ),
                ];
              })
              .expand((element) => element)
              .toList(),
    ));
  }
}
