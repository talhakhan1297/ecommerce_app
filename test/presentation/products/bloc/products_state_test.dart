// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'package:ecommerce_app/domain/products_repository/repository.dart';
import 'package:ecommerce_app/presentation/products/products.dart';
import 'package:ecommerce_app/presentation/utils/helpers/api_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final mockProduct = ProductModel(
    id: 1,
    title: 'accusamus beatae ad facilis cum similique qui sunt',
    price: 10.0,
    description: 'accusamus beatae ad facilis cum similique qui sunt',
    category: 'testCat',
    image: 'https://via.placeholder.com/600/92c952',
    rating: RatingModel(rate: 4.5, count: 10),
  );

  final mockProducts = [mockProduct];

  group('ProductsState', () {
    ProductsState createSubject({
      APICallState state = APICallState.initial,
      List<ProductModel>? data,
      String? error,
    }) {
      return ProductsState(
        productApiState: APIState(state: state, data: data, error: error),
      );
    }

    test('supports value equality', () {
      expect(
        createSubject(),
        equals(createSubject()),
      );
    });

    test(
        'products getter returns products when '
        '[productApiState.data] is not null', () {
      expect(
        createSubject(
          data: mockProducts,
        ).products,
        equals(mockProducts),
      );
    });

    test(
        'products getter returns empty list when '
        '[productApiState.data] is null', () {
      expect(
        createSubject().products,
        equals([]),
      );
    });

    test('props are correct', () {
      expect(
        createSubject(
          state: APICallState.loaded,
          data: mockProducts,
          error: 'error',
        ).props,
        equals(<Object?>[
          APIState(
            state: APICallState.loaded,
            data: mockProducts,
            error: 'error',
          ),
        ]),
      );
      expect(
        createSubject(
          state: APICallState.loaded,
          data: mockProducts,
          error: 'error',
        ).productApiState.props,
        equals(<Object?>[
          mockProducts,
          APICallState.loaded,
          'error',
        ]),
      );
    });

    group('copyWith', () {
      test('returns the same object if not arguments are provided', () {
        expect(
          createSubject().copyWith(),
          equals(createSubject()),
        );
      });

      test('retains the old value for every parameter if null is provided', () {
        expect(
          createSubject().copyWith(productApiState: null),
          equals(createSubject()),
        );
        expect(
          createSubject().productApiState.copyWith(
                data: null,
                state: null,
                error: null,
              ),
          equals(createSubject().productApiState),
        );
      });

      test('replaces every non-null parameter', () {
        expect(
          createSubject().copyWith(
            productApiState: APIState(
              state: APICallState.loaded,
              data: mockProducts,
              error: 'error',
            ),
          ),
          equals(
            createSubject(
              state: APICallState.loaded,
              data: mockProducts,
              error: 'error',
            ),
          ),
        );
        expect(
          createSubject().productApiState.copyWith(
                state: APICallState.loaded,
                data: mockProducts,
                error: 'error',
              ),
          equals(
            createSubject(
              state: APICallState.loaded,
              data: mockProducts,
              error: 'error',
            ).productApiState,
          ),
        );
      });
    });
  });
}
