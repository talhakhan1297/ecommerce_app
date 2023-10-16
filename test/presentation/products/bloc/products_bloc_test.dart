// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:ecommerce_app/data/helpers/exceptions.dart';
import 'package:ecommerce_app/domain/products_repository/repository.dart';
import 'package:ecommerce_app/presentation/products/products.dart';
import 'package:ecommerce_app/presentation/utils/helpers/api_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProductsRepository extends Mock implements ProductsRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ProductsRepository productsRepository;

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

  setUp(() {
    productsRepository = MockProductsRepository();
    when(() => productsRepository.getProducts())
        .thenAnswer((_) async => mockProducts);
  });

  group('ProductsBloc', () {
    test('initial state is correct', () {
      final cubit = ProductsBloc(productsRepository: productsRepository);
      expect(cubit.state, ProductsState());
    });

    group('FetchProductsEvent', () {
      blocTest<ProductsBloc, ProductsState>(
        'verify productsRepository.getProducts is called',
        build: () => ProductsBloc(productsRepository: productsRepository),
        act: (bloc) => bloc.add(FetchProductsEvent()),
        verify: (_) => verify(() => productsRepository.getProducts()).called(1),
      );

      blocTest<ProductsBloc, ProductsState>(
        'emits [APICallState.loading, APICallState.loaded]',
        build: () => ProductsBloc(productsRepository: productsRepository),
        act: (bloc) => bloc.add(FetchProductsEvent()),
        expect: () => <ProductsState>[
          const ProductsState(
            productApiState: APIState<List<ProductModel>>(
              state: APICallState.loading,
            ),
          ),
          ProductsState(
            productApiState: APIState<List<ProductModel>>(
              state: APICallState.loaded,
              data: mockProducts,
            ),
          ),
        ],
      );

      blocTest<ProductsBloc, ProductsState>(
        'emits [APICallState.loading, APICallState.failure]',
        setUp: () {
          when(() => productsRepository.getProducts())
              .thenThrow(FetchDataException());
        },
        build: () => ProductsBloc(productsRepository: productsRepository),
        act: (bloc) => bloc.add(FetchProductsEvent()),
        expect: () => const <ProductsState>[
          ProductsState(
            productApiState: APIState<List<ProductModel>>(
              state: APICallState.loading,
            ),
          ),
          ProductsState(
            productApiState: APIState<List<ProductModel>>(
              state: APICallState.failure,
              error: 'Please check your internet and try again later.',
            ),
          ),
        ],
      );
    });
  });
}
