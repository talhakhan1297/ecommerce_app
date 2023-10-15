// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:ecommerce_app/data/helpers/helpers.dart';
import 'package:ecommerce_app/data/products_api/api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockAPIClient extends Mock implements APIClient {}

void main() {
  const productsEndpoint = '/48b46ae5-16ec-429e-861f-b866ff948552';
  const mockJsonResponse = [
    {
      'id': 1,
      'title': 'accusamus beatae ad facilis cum similique qui sunt',
      'price': 10.0,
      'description': 'accusamus beatae ad facilis cum similique qui sunt',
      'category': 'testCat',
      'image': 'https://via.placeholder.com/600/92c952',
      'rating': {'rate': 4.5, 'count': 10},
    }
  ];

  group('ProductsApi', () {
    late APIClient apiClient;
    late ProductsApi productsApi;

    setUp(() {
      apiClient = MockAPIClient();
      productsApi = ProductsApiImpl(client: apiClient);
    });

    test('can be instantiated', () {
      expect(ProductsApiImpl(), isNotNull);
    });

    group('constructor', () {
      test('does not require an apiClient', () {
        expect(ProductsApiImpl(), isNotNull);
      });
    });

    group('getProducts', () {
      test('makes correct request', () async {
        when(() => apiClient.get(handle: any(named: 'handle')))
            .thenAnswer((_) async => mockJsonResponse);
        try {
          await productsApi.getProducts();
        } catch (_) {}
        verify(() => apiClient.get(handle: productsEndpoint)).called(1);
      });

      test('throws Exception when getProducts fails.', () async {
        when(() => apiClient.get(handle: any(named: 'handle')))
            .thenThrow(SocketException('message'));
        expect(
          () async => productsApi.getProducts(),
          throwsA(isA<Exception>()),
        );
      });

      test('shows correct message on Exception', () async {
        when(() => apiClient.get(handle: any(named: 'handle')))
            .thenThrow(SocketException('message'));
        try {
          await productsApi.getProducts();
        } catch (e) {
          expect(e.toString(), 'SocketException: message');
        }
      });
    });
  });
}
