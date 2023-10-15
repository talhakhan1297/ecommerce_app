// ignore_for_file: prefer_const_constructors

import 'package:ecommerce_app/data/products_api/api.dart';
import 'package:ecommerce_app/domain/products_repository/repository.dart';
import 'package:test/test.dart';

void main() {
  group('ProductModel', () {
    test('supports value equality', () {
      expect(ProductModel(), ProductModel());
    });

    test('props are correct', () {
      expect(
        ProductModel(
          id: 1,
          title: 'accusamus beatae ad facilis cum similique qui sunt',
          price: 10.0,
          description: 'accusamus beatae ad facilis cum similique qui sunt',
          category: 'testCat',
          image: 'https://via.placeholder.com/600/92c952',
          rating: RatingModel(rate: 4.5, count: 10),
        ).props,
        equals(<Object?>[
          1,
          'accusamus beatae ad facilis cum similique qui sunt',
          10.0,
          'accusamus beatae ad facilis cum similique qui sunt',
          'testCat',
          'https://via.placeholder.com/600/92c952',
          RatingModel(rate: 4.5, count: 10),
        ]),
      );
    });

    group('fromJson', () {
      test('returns correct ProductModel object', () {
        expect(
          ProductModel.fromEntity(
            ProductEntity(
              id: 1,
              title: 'accusamus beatae ad facilis cum similique qui sunt',
              price: 10.0,
              description: 'accusamus beatae ad facilis cum similique qui sunt',
              category: 'testCat',
              image: 'https://via.placeholder.com/600/92c952',
              rating: RatingEntity(rate: 4.5, count: 10),
            ),
          ),
          isA<ProductModel>()
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
                RatingModel(rate: 4.5, count: 10),
              ),
        );
      });
    });
  });
}
