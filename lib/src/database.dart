import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

class Location extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get address => text()();
  RealColumn get lat => real()();
  RealColumn get lng => real()();
}

class Category extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get slug => text()();
}

class Product extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  IntColumn get categoryId => integer().references(Category, #id)();
  TextColumn get imageUrl => text()();
  RealColumn get price => real()();
}

@DriftDatabase(tables: [Category, Product, Location])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    return NativeDatabase.createInBackground(file);
  });
}