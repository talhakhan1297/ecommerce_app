// ignore_for_file: prefer_const_constructors

import 'package:ecommerce_app/data/products_api/api.dart';
import 'package:test/test.dart';

void main() {
  group('ProductEntity', () {
    test('supports value equality', () {
      expect(ProductEntity(), ProductEntity());
    });

    test('props are correct', () {
      expect(
        ProductEntity(
          id: 1,
          title: 'accusamus beatae ad facilis cum similique qui sunt',
          price: 10.0,
          description: 'accusamus beatae ad facilis cum similique qui sunt',
          category: 'testCat',
          image: 'https://via.placeholder.com/600/92c952',
          rating: RatingEntity(rate: 4.5, count: 10),
        ).props,
        equals(<Object?>[
          1,
          'accusamus beatae ad facilis cum similique qui sunt',
          10.0,
          'accusamus beatae ad facilis cum similique qui sunt',
          'testCat',
          'https://via.placeholder.com/600/92c952',
          RatingEntity(rate: 4.5, count: 10),
        ]),
      );
    });

    group('fromJson', () {
      test('returns correct ProductEntity object', () {
        expect(
          ProductEntity.fromJson(
            const <String, dynamic>{
              'id': 1,
              'title': 'accusamus beatae ad facilis cum similique qui sunt',
              'price': 10.0,
              'description':
                  'accusamus beatae ad facilis cum similique qui sunt',
              'category': 'testCat',
              'image': 'https://via.placeholder.com/600/92c952',
              'rating': {'rate': 4.5, 'count': 10},
            },
          ),
          isA<ProductEntity>()
              .having((p) => p.id, 'id', 1)
              .having(
                (p) => p.title,
                'title',
                'accusamus beatae ad facilis cum similique qui sunt',
              )
              .having((p) => p.price, 'price', 10.0)
              .having(
                (p) => p.description,
                'description',
                'accusamus beatae ad facilis cum similique qui sunt',
              )
              .having((p) => p.category, 'category', 'testCat')
              .having(
                (p) => p.image,
                'image',
                'https://via.placeholder.com/600/92c952',
              )
              .having(
                (p) => p.rating,
                'rating',
                RatingEntity(rate: 4.5, count: 10),
              ),
        );
      });
    });
  });
}
