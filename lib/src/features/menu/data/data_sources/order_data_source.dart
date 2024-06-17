import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

abstract interface class IOrderDataSource {
  Future<Map<String, dynamic>> createOrder(
      {required Map<String, int> orderJson});
}

final class NetworkOrdersDataSource implements IOrderDataSource {
  final Dio _dio;

  const NetworkOrdersDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<Map<String, dynamic>> createOrder({required Map<String, int> orderJson}) async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    final response = await _dio.post('/orders', data: {"positions": orderJson, "token": fcmToken});

    if (response.statusCode == 201) {
      return response.data;
    } else {
      throw Exception('Failed to create order');
    }
  }
}
