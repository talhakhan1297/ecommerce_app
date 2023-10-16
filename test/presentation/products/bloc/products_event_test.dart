// ignore_for_file: prefer_const_constructors

import 'package:ecommerce_app/presentation/products/products.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProductsEvent', () {
    test('ProductsEvent supports value equality', () {
      expect(
        ProductsEvent(),
        equals(ProductsEvent()),
      );
    });
    test('FetchProductsEvent supports value equality', () {
      expect(
        FetchProductsEvent(),
        equals(FetchProductsEvent()),
      );
    });
  });
}
