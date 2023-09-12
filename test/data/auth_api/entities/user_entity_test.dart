// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:my_ecommerce_bloc_app/data/auth_api/entities/entities.dart';

void main() {
  group('User Entity', () {
    const id = 'mock-id';
    const email = 'mock-email';
    const name = 'mock-name';
    const jsonResposne = {
      'id': '1',
      'email': 'test@test.com',
      'name': 'Test',
    };

    test('uses value equality', () {
      expect(
        UserEntity(email: email, id: id, name: name),
        equals(UserEntity(email: email, id: id, name: name)),
      );
    });

    test('parses json using fromJson', () {
      final user = UserEntity.fromJson(jsonResposne);
      expect(user, isA<UserEntity>());
    });
  });
}
