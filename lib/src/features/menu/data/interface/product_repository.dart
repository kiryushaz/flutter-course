import 'package:flutter_course/src/features/menu/model/category.dart';
import 'package:flutter_course/src/features/menu/model/product.dart';

abstract interface class IProductRepository {
  Future<List<Product>> loadProducts({required Category category, int page = 0, int limit = 25});
}
