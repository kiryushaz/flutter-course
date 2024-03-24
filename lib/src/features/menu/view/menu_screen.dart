import 'package:flutter/material.dart';
import 'package:flutter_course/src/features/menu/data/category_repo.dart';
import 'package:flutter_course/src/features/menu/data/product_repo.dart';
import 'package:flutter_course/src/features/menu/model/category.dart';
import 'package:flutter_course/src/features/menu/model/product.dart';
import 'package:flutter_course/src/features/menu/view/widgets/category_button.dart';

import 'widgets/coffeecard.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final _scrollController = ScrollController();
  List<Category>? categories;
  int _selectedIndex = 0;

  @override
  void initState() {
    loadCategories();
    _scrollController.addListener(() {});
    super.initState();
  }

  Future<void> loadCategories() async {
    categories = await fetchCategories(limit: 10);
    setState(() {});
  }

  void scrollTo(int id) {
    setState(() {
      final targetContext = GlobalObjectKey(id).currentContext;
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
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.shopping_basket), onPressed: () {}),
        body: (categories == null)
            ? const Center(child: CircularProgressIndicator())
            : CustomScrollView(controller: _scrollController, slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                  flexibleSpace: SizedBox(
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      scrollDirection: Axis.horizontal,
                      itemCount: categories!.length,
                      itemBuilder: (context, index) {
                        final category = categories![index];
                        return CategoryButton(
                            text: category.slug,
                            isActive: index == _selectedIndex,
                            onPressed: () {
                              selectCategory(index);
                              scrollTo(category.id);
                            });
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 8.0),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: categories!.length,
                    itemBuilder: (context, index) {
                      final category = categories![index];
                      final products =
                          fetchProducts(categoryId: category.id, limit: 10);
                      return FutureBuilder<List<Product>>(
                        future: products,
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                            final productData = snapshot.data!;
                            return CustomScrollView(shrinkWrap: true, slivers: [
                              SliverPadding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                sliver: SliverToBoxAdapter(
                                  key: GlobalObjectKey(category.id),
                                  child: Text(category.slug,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge),
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
                                    delegate: SliverChildBuilderDelegate(
                                        (context, index) {
                                      return Coffeecard(
                                          coffee: productData[index]);
                                    }, childCount: productData.length)),
                              ),
                            ]);
                          }
                          return const SizedBox();
                        },
                      );
                    },
                  ),
                )
              ]));
  }
}
