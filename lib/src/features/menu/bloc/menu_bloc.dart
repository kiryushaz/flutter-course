import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/src/features/menu/data/category_repo.dart';
import 'package:flutter_course/src/features/menu/data/create_order.dart';
import 'package:flutter_course/src/features/menu/data/product_repo.dart';
import 'package:flutter_course/src/features/menu/model/category.dart';
import 'package:flutter_course/src/features/menu/model/product.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(const MenuInitialState()) {
    on<LoadCategoriesEvent>(_onLoadCategories);
    on<LoadItemsEvent>(_onLoadItems);
    on<AddItemToCartEvent>(_onAddItemToCart);
    on<RemoveItemFromCartEvent>(_onRemoveItemFromCart);
    on<ClearCartEvent>(_onClearCart);
    on<CreateNewOrderEvent>(_onCreateNewOrder);
  }

  Future<void> _onLoadCategories(
      LoadCategoriesEvent event, Emitter<MenuState> emit) async {
    debugPrint("fetching categories");
    try {
      final categories = await fetchCategories();
      emit(MenuLoadingState(
          categories: categories, items: state.items, cartItems: const []));
    } catch (e) {
      emit(MenuFailureState(exception: e));
    }
  }

  Future<void> _onLoadItems(
      LoadItemsEvent event, Emitter<MenuState> emit) async {
    try {
      List<Product> items = [];
      for (var category in state.categories!) {
        debugPrint("fetching product with category id = ${category.id}");
        final result = await fetchProducts(categoryId: category.id, limit: 10);
        items.addAll(result);
      }
      emit(MenuSuccessState(
          categories: state.categories,
          items: items,
          cartItems: state.cartItems));
    } catch (e) {
      emit(MenuFailureState(exception: e));
    }
  }

  Future<void> _onAddItemToCart(
      AddItemToCartEvent event, Emitter<MenuState> emit) async {
    List<Product> cart = List<Product>.from(state.cartItems!);
    cart.add(event.item);
    emit(MenuSuccessState(
        categories: state.categories, items: state.items, cartItems: cart));
    debugPrint("Added item to cart");
  }

  Future<void> _onRemoveItemFromCart(
      RemoveItemFromCartEvent event, Emitter<MenuState> emit) async {
    List<Product> cart = List<Product>.from(state.cartItems!);
    cart.remove(event.item);
    emit(MenuSuccessState(
        categories: state.categories, items: state.items, cartItems: cart));
    debugPrint("Remove item from cart");
  }

  Future<void> _onClearCart(
      ClearCartEvent event, Emitter<MenuState> emit) async {
    emit(MenuSuccessState(
        categories: state.categories, items: state.items, cartItems: const []));
    debugPrint("Cart cleared");
  }

  Future<void> _onCreateNewOrder(
      CreateNewOrderEvent event, Emitter<MenuState> emit) async {
    try {
      final result = await createOrder(event.orderJson);
      debugPrint('$result');
    } on Exception catch (e) {
      debugPrint("Exception: $e");
    }
    debugPrint("Create new order");
  }
}
