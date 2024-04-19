import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_course/src/features/menu/model/category.dart';
import 'package:flutter_course/src/features/menu/model/product.dart';

import 'interface/product_repository.dart';

final dio = Dio(BaseOptions(baseUrl: 'https://coffeeshop.academy.effective.band/api/v1'));

final class ProductRepository implements IProductRepository {
  final Dio _dio;

  const ProductRepository({required Dio dio}) : _dio = dio;

  @override
  Future<List<Product>> loadProducts({required Category category, int page = 0, int limit = 25}) async {
    final response = await _dio.get('/products', queryParameters: {
      'category': category.id,
      'page': page,
      'limit': limit
    });

    if (response.statusCode == 200) {
      final data = response.data!['data'].map((json) => Product.fromJson(json));
      return List<Product>.from(data);
    } else {
      throw const SocketException('Failed to load products');
    }
  }
}
