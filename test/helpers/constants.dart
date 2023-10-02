import 'package:my_ecommerce_bloc_app/data/auth_api/entities/entities.dart';
import 'package:my_ecommerce_bloc_app/domain/auth_repository/dtos/dtos.dart';

const id = 'mock-id';
const email = 'mock-email';
const name = 'mock-name';
const password = 'mock-password';
const signUpDto = SignUpDto(name: name, email: email, password: password);
const signInDto = SignInDto(email: email, password: password);
const signInResponse = SignInDto(email: email, password: password);
const userJsonResposne = {
  'id': '1',
  'email': 'test@test.com',
  'name': 'Test',
};

final user = UserEntity.fromJson(userJsonResposne);
