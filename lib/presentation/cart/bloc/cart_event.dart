part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class FetchCartEvent extends CartEvent {}

class AddItemEvent extends CartEvent {
  const AddItemEvent(this.item);

  final CartItemModel item;

  @override
  List<Object> get props => [item];
}

class RemoveItemEvent extends CartEvent {
  const RemoveItemEvent(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}

class IncrementItemEvent extends CartEvent {
  const IncrementItemEvent(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}

class DecrementItemEvent extends CartEvent {
  const DecrementItemEvent(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}

class ClearCartEvent extends CartEvent {}
