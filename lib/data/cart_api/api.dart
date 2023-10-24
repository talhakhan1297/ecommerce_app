import 'dart:convert';

import 'package:ecommerce_app/common/cache_client/cache_client.dart';
import 'package:ecommerce_app/data/cart_api/entities/entities.dart';
import 'package:flutter/foundation.dart';

export 'package:ecommerce_app/data/cart_api/entities/entities.dart';

part 'cart_api.dart';

abstract class CartApi {
  Future<Map<int, CartItemEntity>> getCartItems();

  Future<void> addCartItem(CartItemEntity item);

  Future<void> removeCartItem(int id);

  Future<void> incrementCartItem(int id);

  Future<void> decrementCartItem(int id);

  Future<void> clearCart();

  Future<void> dispose();
}
