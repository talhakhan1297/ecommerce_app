// ignore_for_file: prefer_const_constructors

import 'package:ecommerce_app/data/products_api/api.dart';
import 'package:test/test.dart';

void main() {
  group('RatingEntity', () {
    test('supports value equality', () {
      expect(RatingEntity(), RatingEntity());
    });

    test('props are correct', () {
      expect(
        RatingEntity(rate: 4.5, count: 10).props,
        equals(<Object?>[4.5, 10]),
      );
    });

    group('fromJson', () {
      test('returns correct RatingEntity object', () {
        expect(
          RatingEntity.fromJson(const {'rate': 4.5, 'count': 10}),
          isA<RatingEntity>()
              .having((p) => p.rate, 'rate', 4.5)
              .having((p) => p.count, 'count', 10.0),
        );
      });
    });

    group('toJson', () {
      test('returns correct Map object', () {
        expect(
          RatingEntity(rate: 4.5, count: 10).toJson,
          {'rate': 4.5, 'count': 10},
        );
      });
    });
  });
}
