// ignore_for_file: prefer_const_constructors

import 'package:ecommerce_app/data/products_api/api.dart';
import 'package:ecommerce_app/domain/products_repository/repository.dart';
import 'package:test/test.dart';

void main() {
  group('RatingModel', () {
    test('supports value equality', () {
      expect(RatingModel(), RatingModel());
    });

    test('props are correct', () {
      expect(
        RatingModel(rate: 4.5, count: 10).props,
        equals(<Object?>[4.5, 10]),
      );
    });

    group('fromJson', () {
      test('returns correct RatingModel object', () {
        expect(
          RatingModel.fromEntity(RatingEntity(rate: 4.5, count: 10)),
          isA<RatingModel>()
              .having((p) => p.rate, 'rate', 4.5)
              .having((p) => p.count, 'count', 10),
        );
      });
    });
  });
}
