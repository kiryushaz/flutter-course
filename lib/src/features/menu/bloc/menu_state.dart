part of 'menu_bloc.dart';

enum OrderStatus {
  none,
  success,
  failure
}

sealed class MenuState extends Equatable {
  final List<Category>? categories;
  final List<Product>? items;
  final List<Product>? cartItems;
  final OrderStatus status;

  const MenuState({this.categories, this.items, this.cartItems, this.status = OrderStatus.none});
}

final class MenuLoadingCategoriesState extends MenuState {
  const MenuLoadingCategoriesState({super.categories, super.items, super.cartItems, super.status});
  
  @override
  List<Object?> get props => [super.categories, super.items, super.cartItems, super.status];
}

final class MenuLoadingProductsState extends MenuState {
  const MenuLoadingProductsState({super.categories, super.items, super.cartItems, super.status});
  
  @override
  List<Object?> get props => [super.categories, super.items, super.cartItems, super.status];
}

final class MenuSuccessState extends MenuState {
  const MenuSuccessState({super.categories, super.items, super.cartItems, super.status});
  
  @override
  List<Object?> get props => [super.categories, super.items, super.cartItems, super.status];
}

final class MenuFailureState extends MenuState {
  final Object? exception;

  const MenuFailureState({this.exception});
  
  @override
  List<Object?> get props => [exception];
}
