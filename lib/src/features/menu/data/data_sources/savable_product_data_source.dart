import 'package:drift/drift.dart';
import 'package:flutter_course/src/database.dart' as db;
import 'package:flutter_course/src/features/menu/data/data_sources/product_data_source.dart';
import 'package:flutter_course/src/features/menu/model/category.dart';
import 'package:flutter_course/src/features/menu/model/price.dart';
import 'package:flutter_course/src/features/menu/model/product.dart';

abstract interface class ISavableProductsDataSource
    implements IProductsDataSource {
  Future<void> saveProducts({required List<Product> products});
}

final class DbProductsSource implements ISavableProductsDataSource {
  final db.AppDatabase _db;

  const DbProductsSource({required db.AppDatabase db}) : _db = db;

  @override
  Future<List<Product>> fetchProducts(
      {required int categoryId, int page = 0, int limit = 25}) async {
    List<Product> data = [];
    final result = await (_db.select(_db.product)
          ..where((u) =>
              u.id.isBiggerThanValue(limit * page) &
              u.categoryId.equals(categoryId))
          ..limit(limit))
        .get();
    for (var elem in result) {
      final cat = await (_db.select(_db.category)
            ..where((u) => u.id.equals(elem.categoryId)))
          .getSingle();
      data.add(Product(
          id: elem.id,
          name: elem.name,
          description: elem.description,
          imageUrl: elem.imageUrl,
          prices: [Price(value: elem.price.toString(), currency: 'RUB')],
          category: Category(id: cat.id, slug: cat.slug)));
    }
    return data;
  }

  @override
  Future<void> saveProducts({required List<Product> products}) async {
    for (var product in products) {
      _db.into(_db.product).insertOnConflictUpdate(
            db.ProductCompanion.insert(
              id: Value(product.id),
              name: product.name,
              description: product.description,
              imageUrl: product.imageUrl,
              price: double.parse(product.prices[0].value),
              categoryId: product.category.id,
            ),
          );
    }
  }
}
