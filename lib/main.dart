import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_course/src/app.dart';
import 'package:flutter_course/src/bloc_observer.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'package:bloc/bloc.dart';

void main() {
  AndroidYandexMap.useAndroidViewSurface = false;
  Bloc.observer = const MyBlocObserver();

  runZonedGuarded(() => runApp(const CoffeeShopApp()), (error, stack) {
    log(error.toString(), name: 'App Error', stackTrace: stack);
  });

  WidgetsFlutterBinding.ensureInitialized();
}
