import 'package:ecommerce_app/data/products_api/api.dart';
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