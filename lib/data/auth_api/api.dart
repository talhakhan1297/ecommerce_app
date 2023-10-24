import 'package:ecommerce_app/data/auth_api/config/auth_endpoints.dart';
import 'package:ecommerce_app/data/auth_api/entities/user_entity.dart';
import 'package:ecommerce_app/data/helpers/api_client.dart';
import 'package:ecommerce_app/domain/auth_repository/repository.dart';

export '../../domain/auth_repository/dtos/dtos.dart';
export 'entities/entities.dart';

part 'auth_api.dart';

abstract class AuthApi {
  Future<UserEntity> signIn(SignInDto dto);

  Future<UserEntity> signUp(SignUpDto dto);

  Future<void> updateProfile();
}
