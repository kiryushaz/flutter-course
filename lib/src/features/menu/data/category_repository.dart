import 'dart:io';

import 'package:flutter_course/src/features/menu/data/data_sources/category_data_source.dart';
import 'package:flutter_course/src/features/menu/data/data_sources/savable_category_data_source.dart';
import 'package:flutter_course/src/features/menu/model/category.dart';

abstract interface class ICategoryRepository {
  Future<List<Category>> loadCategories({int page = 0, int limit = 25});
}

final class CategoryRepository implements ICategoryRepository {
  final ICategoriesDataSource _networkCategoriesDataSource;
  final ISavableCategoriesDataSource _dbCategoriesDataSource;

  const CategoryRepository({
    required ICategoriesDataSource networkCategoriesDataSource,
    required ISavableCategoriesDataSource dbCategoriesDataSource,
  }) : _networkCategoriesDataSource = networkCategoriesDataSource,
  _dbCategoriesDataSource = dbCategoriesDataSource;

  @override
  Future<List<Category>> loadCategories({int page = 0, int limit = 25}) async {
    var data = <Category>[];
    try {
      data = await _networkCategoriesDataSource.fetchCategories();
      _dbCategoriesDataSource.saveCategories(categories: data);
    } on SocketException {
      data = await _dbCategoriesDataSource.fetchCategories();
    }
    return data;
  }
}
