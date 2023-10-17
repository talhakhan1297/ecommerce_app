import 'package:ecommerce_app/data/products_api/entities/rating_entity.dart';
import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  const ProductEntity({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    return ProductEntity(
      id: json['id'] as int?,
      title: json['title'] as String?,
      price: json['price'] as num?,
      description: json['description'] as String?,
      category: json['category'] as String?,
      image: json['image'] as String?,
      rating: json['rating'] == null
          ? null
          : RatingEntity.fromJson(json['rating'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> get toJson => {
        'id': id,
        'title': title,
        'price': price,
        'description': description,
        'category': category,
        'image': image,
        'rating': rating?.toJson,
      };

  final int? id;
  final String? title;
  final num? price;
  final String? description;
  final String? category;
  final String? image;
  final RatingEntity? rating;

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
