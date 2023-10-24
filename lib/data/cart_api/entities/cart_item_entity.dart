import 'package:ecommerce_app/data/products_api/api.dart';
import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable {
  const CartItemEntity({
    required this.product,
    this.quantity = 1,
  });

  factory CartItemEntity.fromJson(Map<String, dynamic> json) {
    return CartItemEntity(
      product: ProductEntity.fromJson(json['product'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
    );
  }

  Map<String, dynamic> get toJson => {
        'product': product.toJson,
        'quantity': quantity,
      };

  CartItemEntity get increment =>
      CartItemEntity(product: product, quantity: quantity + 1);

  CartItemEntity get decrement {
    final quantity = (this.quantity > 1) ? this.quantity - 1 : this.quantity;
    return CartItemEntity(product: product, quantity: quantity);
  }

  final ProductEntity product;
  final int quantity;

  @override
  List<Object?> get props => [product, quantity];
}
