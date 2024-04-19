import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_course/src/features/menu/model/location.dart';

abstract interface class ILocationsDataSource {
  Future<List<Location>> fetchLocations({int page = 0, int limit = 25});
}

final class NetworkLocationsDataSource implements ILocationsDataSource {
  final Dio _dio;

  const NetworkLocationsDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<List<Location>> fetchLocations({int page = 0, int limit = 25}) async {
    final response = await _dio
        .get('/locations', queryParameters: {'page': page, 'limit': limit});

    if (response.statusCode == 200) {
      final List data = response.data!['data'];
      for (int i = 0; i < data.length;) {
        data[i].putIfAbsent("id", () => ++i);
      }
      return List<Location>.of(data.map((json) => Location.fromJson(json)));
    } else {
      throw const SocketException('Failed to load locations');
    }
  }
}
