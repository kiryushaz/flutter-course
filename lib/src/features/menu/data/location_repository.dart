import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_course/src/features/menu/data/data_sources/location_data_source.dart';
import 'package:flutter_course/src/features/menu/data/data_sources/savable_location_data_source.dart';
import 'package:flutter_course/src/features/menu/model/location.dart';

abstract interface class ILocationRepository {
  Future<List<Location>> loadLocations({int page = 0, int limit = 25});
}

final class LocationRepository implements ILocationRepository {
  final ILocationsDataSource _networkLocationsDataSource;
  final ISavableLocationsDataSource _dbLocationsDataSource;

  const LocationRepository({
    required ILocationsDataSource networkLocationsDataSource,
    required ISavableLocationsDataSource dbLocationsDataSource,
  }) : _networkLocationsDataSource = networkLocationsDataSource,
  _dbLocationsDataSource = dbLocationsDataSource;

  @override
  Future<List<Location>> loadLocations({int page = 0, int limit = 25}) async {
    var data = <Location>[];
    try {
      data = await _networkLocationsDataSource.fetchLocations();
      _dbLocationsDataSource.saveLocations(locations: data);
    } on DioException {
      data = await _dbLocationsDataSource.fetchLocations();
    } on SocketException {
      data = await _dbLocationsDataSource.fetchLocations();
    }
    return data;
  }
}
