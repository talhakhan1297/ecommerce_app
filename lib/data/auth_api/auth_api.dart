part of 'api.dart';

class AuthApiImpl extends AuthApi {
  AuthApiImpl({APIClient? client}) : _client = client ?? APIClient();

  final APIClient _client;

  @override
  Future<UserEntity> signIn(SignInDto dto) async {
    final data = await _client.post(handle: AuthEndpoints.signIn);
    return UserEntity.fromJson(data as Map<String, dynamic>);
  }

  @override
  Future<UserEntity> signUp(SignUpDto dto) async {
    final data = await _client.post(handle: AuthEndpoints.signUp);
    return UserEntity.fromJson(data as Map<String, dynamic>);
  }
}
