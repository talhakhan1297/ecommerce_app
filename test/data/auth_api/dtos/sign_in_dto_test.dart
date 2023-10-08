// ignore_for_file: prefer_const_constructors

import 'package:ecommerce_app/domain/auth_repository/dtos/dtos.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/constants.dart';

void main() {
  test('Sign in Dto', () {
    expect(
      SignInDto(email: email, password: password),
      SignInDto(email: email, password: password),
    );
  });
}
