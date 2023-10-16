import 'package:ecommerce_app/data/products_api/api.dart';
import 'package:equatable/equatable.dart';

class RatingModel extends Equatable {
  const RatingModel({this.rate, this.count});

  factory RatingModel.fromEntity(RatingEntity entity) {
    return RatingModel(rate: entity.rate, count: entity.count);
  }

  final num? rate;
  final int? count;

  @override
  List<Object?> get props => [rate, count];
}
