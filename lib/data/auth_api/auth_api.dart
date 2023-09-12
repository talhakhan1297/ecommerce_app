part of 'api.dart';

class AuthApiImpl extends AuthApi {
  @override
  Future<UserEntity> signIn(SignInDto dto) async {
    await Future<void>.delayed(const Duration(seconds: 2));
    return const UserEntity(id: '1', name: 'Talha', email: 'talha@mail.com');
  }

  @override
  Future<UserEntity> signUp(SignUpDto dto) async {
    await Future<void>.delayed(const Duration(seconds: 2));
    return const UserEntity(id: '1', name: 'Talha', email: 'talha@mail.com');
  }
}
