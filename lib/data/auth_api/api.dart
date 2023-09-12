import 'package:my_ecommerce_bloc_app/data/auth_api/dtos/dtos.dart';
import 'package:my_ecommerce_bloc_app/data/auth_api/entities/user_entity.dart';

part 'auth_api.dart';

abstract class AuthApi {
  Future<UserEntity> signIn(SignInDto dto);

  Future<UserEntity> signUp(SignUpDto dto);
}
