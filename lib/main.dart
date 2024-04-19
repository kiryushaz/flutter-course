import 'package:flutter/material.dart';
import 'package:flutter_course/src/app.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

void main() {
  AndroidYandexMap.useAndroidViewSurface = false;

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CoffeeShopApp());
}
