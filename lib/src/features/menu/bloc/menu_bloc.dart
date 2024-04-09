import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_course/src/features/menu/data/category_repository.dart';
import 'package:flutter_course/src/features/menu/data/order_repository.dart';
import 'package:flutter_course/src/features/menu/data/product_repository.dart';
import 'package:flutter_course/src/features/menu/model/category.dart';
import 'package:flutter_course/src/features/menu/model/product.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final IProductRepository _productRepository;
  final ICategoryRepository _categoryRepository;
  final IOrderRepository _orderRepository;
  
  MenuBloc({
    required IProductRepository productRepository, 
    required ICategoryRepository categoryRepository,
    required IOrderRepository orderRepository,
  }) : 
  _productRepository = productRepository, 
  _categoryRepository = categoryRepository, 
  _orderRepository = orderRepository,
  super(const MenuLoadingCategoriesState()) {
    on<LoadCategoriesEvent>(_onLoadCategories);
    on<LoadItemsEvent>(_onLoadItems);
    on<AddItemToCartEvent>(_onAddItemToCart);
    on<RemoveItemFromCartEvent>(_onRemoveItemFromCart);
    on<ClearCartEvent>(_onClearCart);
    on<CreateNewOrderEvent>(_onCreateNewOrder);
  }

  Future<void> _onLoadCategories(
    LoadCategoriesEvent event, 
    Emitter<MenuState> emit
  ) async {
    log("fetching categories");
    try {
      final categories = await _categoryRepository.loadCategories();
      emit(MenuLoadingProductsState(
          categories: categories, items: state.items, cartItems: const []));
    } catch (e) {
      emit(MenuFailureState(exception: e));
    }
  }

  Future<void> _onLoadItems(
    LoadItemsEvent event, 
    Emitter<MenuState> emit
  ) async {
    try {
      List<Product> items = [];
      for (var category in state.categories!) {
        log("fetching product with category id = ${category.id}");
        final result = await _productRepository.loadProducts(category: category, limit: 10);
        items.addAll(result);
        emit(MenuSuccessState(
            categories: state.categories,
            items: items,
            cartItems: state.cartItems));
      }
    } catch (e) {
      emit(MenuFailureState(exception: e));
    }
  }

  Future<void> _onAddItemToCart(
    AddItemToCartEvent event, 
    Emitter<MenuState> emit
  ) async {
    List<Product> cart = List<Product>.from(state.cartItems!);
    cart.add(event.item);
    emit(MenuSuccessState(
        categories: state.categories, items: state.items, cartItems: cart));
    log("Added item to cart");
  }

  Future<void> _onRemoveItemFromCart(
    RemoveItemFromCartEvent event, 
    Emitter<MenuState> emit
  ) async {
    List<Product> cart = List<Product>.from(state.cartItems!);
    cart.remove(event.item);
    emit(MenuSuccessState(
        categories: state.categories, items: state.items, cartItems: cart));
    log("Remove item from cart");
  }

  Future<void> _onClearCart(
    ClearCartEvent event, 
    Emitter<MenuState> emit
  ) async {
    emit(MenuSuccessState(
        categories: state.categories, items: state.items, cartItems: const []));
    log("Cart cleared");
  }

  Future<void> _onCreateNewOrder(
    CreateNewOrderEvent event, 
    Emitter<MenuState> emit
  ) async {
    try {
      final result = await _orderRepository.loadOrder(orderJson: event.orderJson);
      log('$result');
      emit(MenuSuccessState(
        categories: state.categories, 
        items: state.items, 
        cartItems: state.cartItems, 
        status: OrderStatus.success));
    } on Exception catch (e) {
      emit(MenuSuccessState(
        categories: state.categories, 
        items: state.items, 
        cartItems: state.cartItems, 
        status: OrderStatus.failure));
      log("Exception: $e");
    }
    log("Create new order");
  }
}
