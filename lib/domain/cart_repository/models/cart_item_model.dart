import 'package:ecommerce_app/data/cart_api/api.dart';
import 'package:ecommerce_app/domain/products_repository/repository.dart';
import 'package:equatable/equatable.dart';

class CartItemModel extends Equatable {
  const CartItemModel({
    required this.product,
    this.quantity = 1,
  });

  factory CartItemModel.fromEntity(CartItemEntity entity) {
    return CartItemModel(
      product: ProductModel.fromEntity(entity.product),
      quantity: entity.quantity,
    );
  }

  CartItemEntity get toEntity =>
      CartItemEntity(product: product.toEntity, quantity: quantity);

  num get totalPrice => product.price! * quantity;

  String get itemTotalPriceText {
    if (product.price == null) return 'Unknown';
    final priceText = (product.price! * quantity).toStringAsFixed(2);
    return '\$$priceText';
  }

  final ProductModel product;
  final int quantity;

  @override
  List<Object?> get props => [product, quantity];
}
