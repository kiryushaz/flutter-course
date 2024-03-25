import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/src/features/menu/data/category_repo.dart';
import 'package:flutter_course/src/features/menu/data/product_repo.dart';
import 'package:flutter_course/src/features/menu/model/category.dart';
import 'package:flutter_course/src/features/menu/model/product.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(const MenuInitialState()) {
    on<MenuEvent>((event, emit) async {
      switch (event) {
        case LoadCategoriesEvent():
          try {
            if (state is! MenuSuccessState) {
              emit(const MenuLoadingState());
            }
            final categories = await fetchCategories();
            emit(MenuSuccessState(categories: categories, items: state.items));
          } catch (e) {
            emit(MenuFailureState(exception: e));
          }
          break;
        case LoadItemsEvent():
          try {
            if (state is! MenuSuccessState) {
              emit(const MenuLoadingState());
            }
            final items = await fetchProducts();
            emit(MenuSuccessState(categories: state.categories, items: items));
          } catch (e) {
            emit(MenuFailureState(exception: e));
          }
          break;
        case AddItemToCartEvent():
          debugPrint("Added item to cart");
          break;
        case RemoveItemFromCartEvent():
          debugPrint("Remove item from cart");
          break;
        case CreateNewOrderEvent():
          debugPrint("Create new order");
          break;
        default:
          break;
      }
    });
  }
}
