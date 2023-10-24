import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/common/custom_exception.dart';
import 'package:ecommerce_app/domain/cart_repository/repository.dart';
import 'package:ecommerce_app/presentation/utils/helpers/api_state.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({
    required CartRepository cartRepository,
  })  : _repository = cartRepository,
        super(const CartState()) {
    on<FetchCartEvent>((_, emit) => _onFetchCartEvent(emit));
    on<AddItemEvent>(_onAddItemEvent);
    on<RemoveItemEvent>(_onRemoveItemEvent);
    on<IncrementItemEvent>(_onIncrementItemEvent);
    on<DecrementItemEvent>(_onDecrementItemEvent);
    on<ClearCartEvent>(_onClearCartEvent);
  }

  final CartRepository _repository;

  Future<void> _onFetchCartEvent(Emitter<CartState> emit) async {
    emit(state.copyWith(getCartState: state.getCartState.toLoading()));

    try {
      final data = await _repository.getCartItems();

      emit(
        state.copyWith(getCartState: state.getCartState.toLoaded(data: data)),
      );
    } on CustomException catch (e) {
      emit(
        state.copyWith(
          getCartState: state.getCartState.toFailure(error: e.message),
        ),
      );
    } catch (_) {
      emit(state.copyWith(getCartState: state.getCartState.toFailure()));
    }
  }

  Future<void> _onAddItemEvent(
    AddItemEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(addItemState: state.addItemState.toLoading()));

    try {
      await _repository.addCartItem(event.item);
      await _onFetchCartEvent(emit);

      emit(state.copyWith(addItemState: state.addItemState.toLoaded()));
    } on CustomException catch (e) {
      emit(
        state.copyWith(
          addItemState: state.addItemState.toFailure(error: e.message),
        ),
      );
    } catch (_) {
      emit(state.copyWith(addItemState: state.addItemState.toFailure()));
    }
  }

  Future<void> _onRemoveItemEvent(
    RemoveItemEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(removeItemState: state.removeItemState.toLoading()));

    try {
      await _repository.removeCartItem(event.id);
      await _onFetchCartEvent(emit);

      emit(state.copyWith(removeItemState: state.removeItemState.toLoaded()));
    } on CustomException catch (e) {
      emit(
        state.copyWith(
          removeItemState: state.removeItemState.toFailure(error: e.message),
        ),
      );
    } catch (_) {
      emit(state.copyWith(removeItemState: state.removeItemState.toFailure()));
    }
  }

  Future<void> _onIncrementItemEvent(
    IncrementItemEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(
      state.copyWith(incrementItemState: state.incrementItemState.toLoading()),
    );

    try {
      await _repository.incrementCartItem(event.id);
      await _onFetchCartEvent(emit);

      emit(
        state.copyWith(incrementItemState: state.incrementItemState.toLoaded()),
      );
    } on CustomException catch (e) {
      emit(
        state.copyWith(
          incrementItemState:
              state.incrementItemState.toFailure(error: e.message),
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          incrementItemState: state.incrementItemState.toFailure(),
        ),
      );
    }
  }

  Future<void> _onDecrementItemEvent(
    DecrementItemEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(
      state.copyWith(decrementItemState: state.decrementItemState.toLoading()),
    );

    try {
      await _repository.decrementCartItem(event.id);
      await _onFetchCartEvent(emit);

      emit(
        state.copyWith(decrementItemState: state.decrementItemState.toLoaded()),
      );
    } on CustomException catch (e) {
      emit(
        state.copyWith(
          decrementItemState:
              state.decrementItemState.toFailure(error: e.message),
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          decrementItemState: state.decrementItemState.toFailure(),
        ),
      );
    }
  }

  Future<void> _onClearCartEvent(
    ClearCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(state.copyWith(clearCartState: state.clearCartState.toLoading()));

    try {
      await _repository.clearCart();
      await _onFetchCartEvent(emit);

      emit(state.copyWith(clearCartState: state.clearCartState.toLoaded()));
    } on CustomException catch (e) {
      emit(
        state.copyWith(
          clearCartState: state.clearCartState.toFailure(error: e.message),
        ),
      );
    } catch (_) {
      emit(state.copyWith(clearCartState: state.clearCartState.toFailure()));
    }
  }
}
