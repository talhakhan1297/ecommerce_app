import 'package:ecommerce_app/data/products_api/api.dart';
import 'package:ecommerce_app/domain/cart_repository/repository.dart';
import 'package:ecommerce_app/domain/products_repository/models/models.dart';
import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  const ProductModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      title: entity.title,
      price: entity.price,
      description: entity.description,
      category: entity.category,
      image: entity.image,
      rating:
          entity.rating == null ? null : RatingModel.fromEntity(entity.rating!),
    );
  }

  final int? id;
  final String? title;
  final num? price;
  final String? description;
  final String? category;
  final String? image;
  final RatingModel? rating;

  ProductEntity get toEntity => ProductEntity(
        id: id,
        title: title,
        price: price,
        description: description,
        category: category,
        image: image,
        rating: rating?.toEntity,
      );

  String get titleText => title ?? 'Untitled';

  String get priceText => price != null ? '\$$price' : 'Unknown';

  String? get ratingText =>
      rating?.rate == null ? null : '⭐ ${rating?.rate} $_ratingCountText';

  String get _ratingCountText =>
      rating?.count != null ? '(${rating?.count})' : '';

  CartItemModel get toCartItem => CartItemModel(product: this);

  @override
  List<Object?> get props => [
        id,
        title,
        price,
        description,
        category,
        image,
        rating,
      ];
}
