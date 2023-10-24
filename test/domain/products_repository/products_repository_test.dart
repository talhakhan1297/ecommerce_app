// ignore_for_file: prefer_const_constructors
import 'package:ecommerce_app/data/products_api/api.dart';
import 'package:ecommerce_app/domain/products_repository/repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockProductsApi extends Mock implements ProductsApi {}

void main() {
  const mockResponse = [
    ProductEntity(
      id: 1,
      title: 'accusamus beatae ad facilis cum similique qui sunt',
      price: 10.0,
      description: 'accusamus beatae ad facilis cum similique qui sunt',
      category: 'testCat',
      image: 'https://via.placeholder.com/600/92c952',
      rating: RatingEntity(rate: 4.5, count: 10),
    ),
  ];

  group('ProductsRepository', () {
    late ProductsApi productsApi;
    late ProductsRepository productsRepository;

    setUp(() {
      productsApi = MockProductsApi();
      productsRepository = ProductsRepositoryImpl(productsApi: productsApi);
    });

    test('can be instantiated', () {
      expect(ProductsRepositoryImpl(), isNotNull);
    });

    group('constructor', () {
      test('does not require an ProductsApi', () {
        expect(ProductsRepositoryImpl(), isNotNull);
      });
    });

    group('getProducts', () {
      test('makes correct call', () async {
        when(() => productsApi.getProducts())
            .thenAnswer((_) async => mockResponse);

        try {
          await productsRepository.getProducts();
        } catch (_) {}

        verify(() => productsApi.getProducts()).called(1);
      });

      test('throws when getProducts fails', () async {
        final exception = Exception('oops');
        when(() => productsApi.getProducts()).thenThrow(exception);
        expect(
          () async => productsRepository.getProducts(),
          throwsA(exception),
        );
      });
    });
  });
}
