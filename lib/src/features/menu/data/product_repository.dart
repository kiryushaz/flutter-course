import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_course/src/features/menu/data/data_sources/product_data_source.dart';
import 'package:flutter_course/src/features/menu/data/data_sources/savable_product_data_source.dart';
import 'package:flutter_course/src/features/menu/model/category.dart';
import 'package:flutter_course/src/features/menu/model/product.dart';

abstract interface class IProductRepository {
  Future<List<Product>> loadProducts(
      {required Category category, int page = 0, int limit = 25});
}

final class ProductRepository implements IProductRepository {
  final IProductsDataSource _networkProductsDataSource;
  final ISavableProductsDataSource _dbProductsDataSource;

  const ProductRepository(
      {required IProductsDataSource networkProductsDataSource,
      required ISavableProductsDataSource dbProductsDataSource})
      : _networkProductsDataSource = networkProductsDataSource,
        _dbProductsDataSource = dbProductsDataSource;

  @override
  Future<List<Product>> loadProducts(
      {required Category category, int page = 0, int limit = 25}) async {
    var data = <Product>[];
    try {
      data = await _networkProductsDataSource.fetchProducts(
          categoryId: category.id, page: page, limit: limit);
      _dbProductsDataSource.saveProducts(products: data);
    } on DioException {
      data = await _dbProductsDataSource.fetchProducts(
          categoryId: category.id, page: page, limit: limit);
    } on SocketException {
      data = await _dbProductsDataSource.fetchProducts(
          categoryId: category.id, page: page, limit: limit);
    }
    return data;
  }
}
