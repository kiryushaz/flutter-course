import 'package:flutter_course/src/features/menu/data/category_data.dart';
import 'package:flutter_course/src/features/menu/model/coffee.dart';

List<Coffee> coffee = [
  Coffee(name: "Эспрессо", price: 139, image: "assets/images/coffee.png", category: categories[0]['data']),
  Coffee(name: "Американо", price: 139, category: categories[0]['data']),
  Coffee(name: "Ристретто", price: 139, image: "assets/images/coffee.png", category: categories[0]['data']),
  Coffee(name: "Романо", price: 139, category: categories[0]['data']),
  Coffee(name: "Капучино", price: 139, image: "assets/images/coffee.png", category: categories[1]['data']),
  Coffee(name: "Латте", price: 139, category: categories[1]['data']),
  Coffee(name: "Чай черный", price: 139, image: "assets/images/coffee.png", category: categories[2]['data']),
  Coffee(name: "Чай зеленый", price: 139, category: categories[2]['data']),
  Coffee(name: "Раф Лимонный пирог", price: 139, image: "assets/images/coffee.png", category: categories[3]['data']),
  Coffee(name: "Раф Ванильный", price: 139, category: categories[3]['data']),
];