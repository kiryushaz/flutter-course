import 'category.dart';

class Coffee {
  final String name;
  final String description;
  final Category category;
  final double price;
  final String? image;

  Coffee(this.name, this.description, this.category, this.price, this.image);
}