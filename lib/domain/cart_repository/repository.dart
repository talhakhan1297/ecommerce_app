import 'package:ecommerce_app/data/cart_api/api.dart';
import 'package:ecommerce_app/domain/cart_repository/models/models.dart';

export 'package:ecommerce_app/domain/cart_repository/models/models.dart';

part 'cart_repository.dart';

abstract class CartRepository {
  Future<Map<int, CartItemModel>> getCartItems();

  Future<void> addCartItem(CartItemModel item);

  Future<void> removeCartItem(int id);

  Future<void> incrementCartItem(int id);

  Future<void> decrementCartItem(int id);

  Future<void> clearCart();
}
