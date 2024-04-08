import 'package:flutter_course/src/features/menu/model/category.dart';

abstract interface class ICategoryRepository {
  Future<List<Category>> loadCategories({int page = 0, int limit = 25});
}
