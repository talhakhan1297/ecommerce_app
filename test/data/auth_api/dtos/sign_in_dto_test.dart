// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:my_ecommerce_bloc_app/data/auth_api/dtos/dtos.dart';

import '../../../helpers/constants.dart';

void main() {
  test('Sign in Dto', () {
    expect(
      SignInDto(email: email, password: password),
      SignInDto(email: email, password: password),
    );
  });
}
