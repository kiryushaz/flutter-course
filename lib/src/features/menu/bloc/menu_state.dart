part of 'menu_bloc.dart';

sealed class MenuState extends Equatable {
  final List<Category>? categories;
  final List<Product>? items;

  const MenuState({this.categories, this.items});
}

final class MenuInitialState extends MenuState {
  const MenuInitialState({super.categories, super.items});
  
  @override
  List<Object?> get props => [super.categories, super.items];
}

final class MenuLoadingState extends MenuState {
  const MenuLoadingState({super.categories, super.items});
  
  @override
  List<Object?> get props => [super.categories, super.items];
}

final class MenuSuccessState extends MenuState {
  const MenuSuccessState({super.categories, super.items});
  
  @override
  List<Object?> get props => [super.categories, super.items];
}

final class MenuFailureState extends MenuState {
  final Object? exception;

  const MenuFailureState({this.exception});
  
  @override
  List<Object?> get props => [exception];
}
