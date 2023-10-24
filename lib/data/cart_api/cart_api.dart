part of 'api.dart';

class CartApiImpl extends CartApi {
  CartApiImpl({
    CacheClient? cache,
  }) : _cache = cache ?? HiveCacheClient();

  final CacheClient _cache;

  /// Cart cache key.
  /// Should only be used for testing purposes.
  @visibleForTesting
  static const cartCacheKey = '__cart_cache_key__';

  @override
  Future<Map<int, CartItemEntity>> getCartItems() async {
    final cartString = _cache.read<Map<int, String>>(key: cartCacheKey);

    if (cartString == null) return {};

    final cartJson = cartString.map<int, Map<String, dynamic>>(
      (key, value) => MapEntry(key, jsonDecode(value) as Map<String, dynamic>),
    );

    return cartJson
        .map((key, value) => MapEntry(key, CartItemEntity.fromJson(value)));
  }

  @override
  Future<void> addCartItem(CartItemEntity item) async {
    final cartItems = await getCartItems();

    if (item.product.id == null) return;

    cartItems.addAll({item.product.id!: item});

    _updateCartItems(cartItems);
  }

  @override
  Future<void> removeCartItem(int id) async {
    final cartItems = await getCartItems();

    cartItems.removeWhere((key, _) => key == id);

    _updateCartItems(cartItems);
  }

  @override
  Future<void> incrementCartItem(int id) async {
    final cartItems = await getCartItems();

    final item = cartItems[id];

    if (item == null) return;

    cartItems[id] = item.increment;

    _updateCartItems(cartItems);
  }

  @override
  Future<void> decrementCartItem(int id) async {
    final cartItems = await getCartItems();

    final item = cartItems[id];

    if (item == null) return;

    cartItems[id] = item.decrement;

    _updateCartItems(cartItems);
  }

  @override
  Future<void> clearCart() async {
    await _cache.delete(key: cartCacheKey);
  }

  /// disposes the cache client
  @override
  Future<void> dispose() async {
    await _cache.close();
  }

  void _updateCartItems(Map<int, CartItemEntity> cartItems) {
    final cartJson =
        cartItems.map((key, value) => MapEntry(key, jsonEncode(value.toJson)));

    _cache.write<Map<int, String>>(key: cartCacheKey, value: cartJson);
  }
}
