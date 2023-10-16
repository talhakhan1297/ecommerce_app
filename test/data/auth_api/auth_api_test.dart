import 'package:ecommerce_app/data/auth_api/api.dart';
import 'package:ecommerce_app/data/helpers/helpers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/constants.dart';

class MockAPIClient extends Mock implements APIClient {}

void main() {
  final mockApiClient = MockAPIClient();
  final authApi = AuthApiImpl(client: mockApiClient);
  group('AuthApi', () {
    setUp(() {
      when(() => mockApiClient.get(handle: any(named: 'handle'))).thenAnswer(
        (invocation) async => userJsonResposne,
      );
    });

    test('calls signUp()', () async {
      final response = await authApi.signUp(signUpDto);
      expect(user, response);
    });

    test('calls signIn()', () async {
      final response = await authApi.signIn(signInDto);
      expect(user, response);
    });
  });
}
