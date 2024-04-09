import 'package:drift/drift.dart';
import 'package:flutter_course/src/database.dart' as db;
import 'package:flutter_course/src/features/menu/data/data_sources/location_data_source.dart';
import 'package:flutter_course/src/features/menu/model/location.dart';

abstract interface class ISavableLocationsDataSource implements ILocationsDataSource {
  Future<void> saveLocations({required List<Location> locations});
} 

final class DbLocationsDataSource implements ISavableLocationsDataSource {
  final db.AppDatabase _db;

  const DbLocationsDataSource({required db.AppDatabase db}) : _db = db;

  @override
  Future<List<Location>> fetchLocations({int page = 0, int limit = 25}) async {
    final result = await (_db.select(_db.location)..where((u) => u.id.isBiggerThanValue(limit * page))..limit(limit)).get();
    return List<Location>.of(result.map((e) => Location(id: e.id, address: e.address, lat: e.lat, lng: e.lng)));
  }
  
  @override
  Future<void> saveLocations({required List<Location> locations}) async {
    for (var location in locations) {
      _db.into(_db.location).insertOnConflictUpdate(
        db.LocationCompanion.insert(
          id: Value(location.id), 
          address: location.address,
          lat: location.lat,
          lng: location.lng
        )
      );
    }
  }
}