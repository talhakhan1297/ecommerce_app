// ignore_for_file: prefer_const_constructors

import 'package:ecommerce_app/domain/auth_repository/dtos/dtos.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/constants.dart';

void main() {
  test('Sign up Dto', () {
    expect(
      SignUpDto(email: email, password: password, name: name),
      SignUpDto(email: email, password: password, name: name),
    );
  });
}
