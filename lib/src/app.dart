import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_course/src/database.dart';
import 'package:flutter_course/src/features/menu/bloc/menu_bloc.dart';
import 'package:flutter_course/src/features/menu/data/category_repository.dart';
import 'package:flutter_course/src/features/menu/data/data_sources/category_data_source.dart';
import 'package:flutter_course/src/features/menu/data/data_sources/location_data_source.dart';
import 'package:flutter_course/src/features/menu/data/data_sources/order_data_source.dart';
import 'package:flutter_course/src/features/menu/data/data_sources/product_data_source.dart';
import 'package:flutter_course/src/features/menu/data/data_sources/savable_category_data_source.dart';
import 'package:flutter_course/src/features/menu/data/data_sources/savable_location_data_source.dart';
import 'package:flutter_course/src/features/menu/data/data_sources/savable_product_data_source.dart';
import 'package:flutter_course/src/features/menu/data/location_repository.dart';
import 'package:flutter_course/src/features/menu/data/order_repository.dart';
import 'package:flutter_course/src/features/menu/data/product_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'features/menu/view/menu_screen.dart';
import 'theme/theme.dart';

class CoffeeShopApp extends StatelessWidget {
  static final dio = Dio(
      BaseOptions(baseUrl: 'https://coffeeshop.academy.effective.band/api/v1'));
  static final db = AppDatabase();

  const CoffeeShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MenuBloc(
        locationRepository: LocationRepository(
            networkLocationsDataSource: NetworkLocationsDataSource(dio: dio),
            dbLocationsDataSource: DbLocationsDataSource(db: db)),
        categoryRepository: CategoryRepository(
            networkCategoriesDataSource: NetworkCategoriesDataSource(dio: dio),
            dbCategoriesDataSource: DbCategoriesDataSource(db: db)),
        productRepository: ProductRepository(
            networkProductsDataSource: NetworkProductsDataSource(dio: dio),
            dbProductsDataSource: DbProductsSource(db: db)),
        orderRepository:
            OrderRepository(orderDataSource: NetworkOrdersDataSource(dio: dio)),
      ),
      child: Container(
        color: coffeeAppTheme.colorScheme.background,
        child: SafeArea(
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: coffeeAppTheme,
              title: 'Coffee Shop App',
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: const MenuScreen()),
        ),
      ),
    );
  }
}
