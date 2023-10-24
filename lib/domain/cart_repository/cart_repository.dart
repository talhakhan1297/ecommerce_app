// ignore_for_file: unnecessary_await_in_return

part of 'repository.dart';

class CartRepositoryImpl extends CartRepository {
  CartRepositoryImpl({
    CartApi? cartApi,
  }) : _api = cartApi ?? CartApiImpl();

  final CartApi _api;

  @override
  Future<Map<int, CartItemModel>> getCartItems() async {
    final data = await _api.getCartItems();

    return data
        .map((key, value) => MapEntry(key, CartItemModel.fromEntity(value)));
  }

  @override
  Future<void> addCartItem(CartItemModel item) async =>
      await _api.addCartItem(item.toEntity);

  @override
  Future<void> removeCartItem(int id) async => await _api.removeCartItem(id);

  @override
  Future<void> incrementCartItem(int id) async =>
      await _api.incrementCartItem(id);

  @override
  Future<void> decrementCartItem(int id) async =>
      await _api.decrementCartItem(id);

  @override
  Future<void> clearCart() async => await _api.clearCart();

  Future<void> dispose() async => await _api.dispose();
}
