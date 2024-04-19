import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_course/src/features/menu/bloc/menu_bloc.dart';
import 'package:flutter_course/src/features/menu/data/category_repository.dart';
import 'package:flutter_course/src/features/menu/data/order_repository.dart';
import 'package:flutter_course/src/features/menu/data/product_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'features/menu/view/menu_screen.dart';
import 'theme/theme.dart';

class CoffeeShopApp extends StatelessWidget {
  static final dio = Dio(
      BaseOptions(baseUrl: 'https://coffeeshop.academy.effective.band/api/v1'));

  const CoffeeShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MenuBloc(
        categoryRepository: CategoryRepository(dio: dio),
        productRepository: ProductRepository(dio: dio),
        orderRepository: OrderRepository(dio: dio),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: coffeeAppTheme,
        title: 'Coffee Shop App',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Container(
          color: coffeeAppTheme.colorScheme.background,
          child: const SafeArea(child: MenuScreen()),
        )
      ),
    );
  }
}
