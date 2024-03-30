import 'package:dio/dio.dart';

final dio = Dio(
    BaseOptions(baseUrl: 'https://coffeeshop.academy.effective.band/api/v1'));

Future<Map> createOrder(Map<String, int> orderJson) async {
  final response = await dio.post('/orders', data: {"positions": orderJson, "token": ""});

  if (response.statusCode == 201) {
    return response.data;
  } else {
    throw Exception('Failed to load products');
  }
}
