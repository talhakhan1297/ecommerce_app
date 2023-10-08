part of 'api.dart';

class AuthApiImpl extends AuthApi {
  AuthApiImpl({APIClient? client}) : _client = client ?? APIClient();

  final APIClient _client;

  @override
  Future<UserEntity> signIn(SignInDto dto) async {
    final data = await _client.get(
      handle: AuthEndpoints.signIn,
      // body: dto.toJson(),
    );
    return UserEntity.fromJson(data as Map<String, dynamic>);
  }

  @override
  Future<UserEntity> signUp(SignUpDto dto) async {
    final data = await _client.get(
      handle: AuthEndpoints.signUp,
      // body: dto.toJson(),
    );
    return UserEntity.fromJson(data as Map<String, dynamic>);
  }
}
