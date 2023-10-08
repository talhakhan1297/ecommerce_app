// ignore_for_file: prefer_const_constructors

import 'package:ecommerce_app/data/auth_api/entities/entities.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/constants.dart';

void main() {
  group('User Entity', () {
    test('uses value equality', () {
      expect(
        UserEntity(email: email, id: id, name: name),
        equals(UserEntity(email: email, id: id, name: name)),
      );
    });

    test('parses json using fromJson', () {
      final user = UserEntity.fromJson(userJsonResposne);
      expect(user, isA<UserEntity>());
    });
  });
}
