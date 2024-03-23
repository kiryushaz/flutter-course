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
    _scrollController.addListener(() {});
    super.initState();
  }

  void scrollTo(category) {
    setState(() {
      final targetContext = GlobalObjectKey(category).currentContext;
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
        body: CustomScrollView(controller: _scrollController, slivers: <Widget>[
      SliverAppBar(
        pinned: true,
        elevation: 0,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        flexibleSpace: SizedBox(
          child: ListView.separated(
            shrinkWrap: true,
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return CategoryButton(
                  text: category.name,
                  isActive: index == _selectedIndex,
                  onPressed: () {
                    selectCategory(index);
                    scrollTo(category.name);
                  });
            },
            separatorBuilder: (context, index) => const SizedBox(width: 8.0),
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            List<Coffee> coffeeCat =
                coffee.where((t) => t.category == category).toList();
            return CustomScrollView(shrinkWrap: true, slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverToBoxAdapter(
                  key: GlobalObjectKey(category.name),
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
            ]);
          },
        ),
      )
    ]));
  }
}
