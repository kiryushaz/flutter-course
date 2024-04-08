import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_course/src/features/menu/data/interface/category_repository.dart';
import 'package:flutter_course/src/features/menu/model/category.dart';

final dio = Dio(BaseOptions(baseUrl: 'https://coffeeshop.academy.effective.band/api/v1'));

final class CategoryRepository implements ICategoryRepository {
  final Dio _dio;

  const CategoryRepository({required Dio dio}) : _dio = dio;

  @override
  Future<List<Category>> loadCategories({int page = 0, int limit = 25}) async {
    final response = await _dio.get('/products/categories',
        queryParameters: {'page': page, 'limit': limit});

    if (response.statusCode == 200) {
      final data = response.data!['data'].map((json) => Category.fromJson(json));
      return List<Category>.from(data);
    } else {
      throw const SocketException('Failed to load categories');
    }
  }
}
