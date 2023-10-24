part of 'repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl({
    super.cache,
    super.userAuth,
    AuthApi? authApi,
  }) : api = authApi ?? AuthApiImpl();

  final AuthApi api;

  @override
  Future<void> signIn(SignInDto dto) async {
    final entity = await api.signIn(dto);
    final model = UserModel.fromEntity(entity);
    updateUser(model);
  }

  @override
  Future<void> signUp(SignUpDto dto) async {
    final entity = await api.signUp(dto);
    final model = UserModel.fromEntity(entity);
    updateUser(model);
  }

  @override
  Future<void> signOut() async {
    updateUser(UserModel.empty);
  }

  @override
  Future<void> updateProfile() async {
    await api.updateProfile();
  }
}
