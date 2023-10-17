part of 'cart_bloc.dart';

class CartState extends Equatable {
  const CartState({
    this.getCartState = const APIState<Map<int, CartItemModel>>(),
    this.addItemState = const APIState<void>(),
    this.removeItemState = const APIState<void>(),
    this.incrementItemState = const APIState<void>(),
    this.decrementItemState = const APIState<void>(),
    this.clearCartState = const APIState<void>(),
  });

  final APIState<Map<int, CartItemModel>> getCartState;
  final APIState<void> addItemState;
  final APIState<void> removeItemState;
  final APIState<void> incrementItemState;
  final APIState<void> decrementItemState;
  final APIState<void> clearCartState;

  CartState copyWith({
    APIState<Map<int, CartItemModel>>? getCartState,
    APIState<void>? addItemState,
    APIState<void>? removeItemState,
    APIState<void>? incrementItemState,
    APIState<void>? decrementItemState,
    APIState<void>? clearCartState,
  }) {
    return CartState(
      getCartState: getCartState ?? this.getCartState,
      addItemState: addItemState ?? this.addItemState,
      removeItemState: removeItemState ?? this.removeItemState,
      incrementItemState: incrementItemState ?? this.incrementItemState,
      decrementItemState: decrementItemState ?? this.decrementItemState,
      clearCartState: clearCartState ?? this.clearCartState,
    );
  }

  @override
  List<Object> get props => [
        getCartState,
        addItemState,
        removeItemState,
        incrementItemState,
        decrementItemState,
        clearCartState,
      ];
}
