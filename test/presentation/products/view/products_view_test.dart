// ignore_for_file: prefer_const_constructors

import 'package:ecommerce_app/domain/products_repository/repository.dart';
import 'package:ecommerce_app/presentation/products/products.dart';
import 'package:ecommerce_app/presentation/products/view/products_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockProductsRepository extends Mock implements ProductsRepository {}

void main() {
  late ProductsRepository productsRepository;

  setUp(() {
    productsRepository = MockProductsRepository();
    GetIt.I.registerSingleton(productsRepository);
  });

  tearDown(() {
    GetIt.I.unregister(instance: productsRepository);
  });

  group('ProductsView', () {
    testWidgets('renders ProductsPage', (tester) async {
      await tester.pumpWidget(MaterialApp(home: ProductsView()));
      await tester.pumpAndSettle();
      expect(find.byType(ProductsPage), findsOneWidget);
    });
  });

  group('ProductsView', () {
    testWidgets(
      'calls getProducts on initialization',
      (tester) async {
        await tester.pumpWidget(MaterialApp(home: ProductsView()));
        await tester.pumpAndSettle();
        verify(() => productsRepository.getProducts()).called(1);
      },
    );
  });
}
