import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_course/src/features/menu/model/category.dart';

abstract interface class ICategoriesDataSource {
  Future<List<Category>> fetchCategories({int page = 0, int limit = 25});
}

final class NetworkCategoriesDataSource implements ICategoriesDataSource {
  final Dio _dio;

  const NetworkCategoriesDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<List<Category>> fetchCategories({int page = 0, int limit = 25}) async {
    final response = await _dio.get('/products/categories',
        queryParameters: {'page': page, 'limit': limit});

    if (response.statusCode == 200) {
      final data =
          response.data!['data'].map((json) => Category.fromJson(json));
      return List<Category>.from(data);
    } else {
      throw const SocketException('Failed to load categories');
    }
  }
}
