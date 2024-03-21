import 'category.dart';

class Coffee {
  final String name;
  final int price;
  final String? image;
  final Category category;

  const Coffee({required this.name, required this.price, this.image, required this.category});
}