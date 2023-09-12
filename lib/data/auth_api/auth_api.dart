part of 'api.dart';

class AuthApiImpl extends AuthApi {
  AuthApiImpl({required ApiClient client}) : _client = client;

  final ApiClient _client;

  @override
  Future<UserEntity> signIn(SignInDto dto) async {
    return _client.post() as UserEntity;
  }

  @override
  Future<UserEntity> signUp(SignUpDto dto) async {
    return _client.post() as UserEntity;
  }
}
