import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_course/src/features/menu/model/product.dart';

abstract interface class IProductsDataSource {
  Future<List<Product>> fetchProducts({required int categoryId, int page = 0, int limit = 25});
}

final class NetworkProductsDataSource implements IProductsDataSource {
  final Dio _dio;

  const NetworkProductsDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<List<Product>> fetchProducts({required int categoryId, int page = 0, int limit = 25}) async {
    final response = await _dio.get('/products', queryParameters: {
      'category': categoryId,
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