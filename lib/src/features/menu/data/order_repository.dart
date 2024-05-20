import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_course/src/features/menu/data/data_sources/order_data_source.dart';

abstract interface class IOrderRepository {
  Future<Map<String, dynamic>> loadOrder({required Map<String, int> orderJson});
}

final class OrderRepository implements IOrderRepository {
  final IOrderDataSource _orderDataSource;

  const OrderRepository({
    required IOrderDataSource orderDataSource
  }) : _orderDataSource = orderDataSource;

  @override
  Future<Map<String, dynamic>> loadOrder({required Map<String, int> orderJson}) async {
    try {
      return await _orderDataSource.createOrder(orderJson: orderJson);
    } on DioException {
      return {};
    } on SocketException {
      return {};
    }
  }
}
