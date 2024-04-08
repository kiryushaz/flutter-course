import 'package:dio/dio.dart';
import 'package:flutter_course/src/features/menu/data/interface/order_repository.dart';

final dio = Dio(
    BaseOptions(baseUrl: 'https://coffeeshop.academy.effective.band/api/v1'));

final class OrderRepository implements IOrderRepository {
  final Dio _dio;

  const OrderRepository({required Dio dio}) : _dio = dio;

  @override
  Future<Map> createOrder({required Map<String, int> orderJson}) async {
    final response = await _dio.post('/orders', data: {"positions": orderJson, "token": ""});

    if (response.statusCode == 201) {
      return response.data;
    } else {
      throw Exception('Failed to load products');
    }
  }
}