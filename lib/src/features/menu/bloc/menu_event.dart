part of 'menu_bloc.dart';

sealed class MenuEvent extends Equatable {
  const MenuEvent();
}

final class LoadCategoriesEvent extends MenuEvent {
  const LoadCategoriesEvent();
  
  @override
  List<Object?> get props => throw UnimplementedError();
}

final class LoadItemsEvent extends MenuEvent {
  const LoadItemsEvent();
  
  @override
  List<Object?> get props => throw UnimplementedError();
}

final class AddItemToCartEvent extends MenuEvent {
  const AddItemToCartEvent();

  @override
  List<Object?> get props => throw UnimplementedError();
}

final class RemoveItemFromCartEvent extends MenuEvent {
  const RemoveItemFromCartEvent();

  @override
  List<Object?> get props => throw UnimplementedError();
}

final class CreateNewOrderEvent extends MenuEvent {
  const CreateNewOrderEvent();

  @override
  List<Object?> get props => throw UnimplementedError();
}
