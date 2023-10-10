import 'package:equatable/equatable.dart';

class RatingEntity extends Equatable {
  const RatingEntity({this.rate, this.count});

  factory RatingEntity.fromJson(Map<String, dynamic> json) {
    return RatingEntity(
      rate: json['rate'] as double?,
      count: json['count'] as int?,
    );
  }

  final double? rate;
  final int? count;

  @override
  List<Object?> get props => [rate, count];
}
