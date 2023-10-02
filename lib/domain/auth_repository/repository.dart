import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:my_ecommerce_bloc_app/common/cache_client.dart';
import 'package:my_ecommerce_bloc_app/data/auth_api/api.dart';
import 'package:my_ecommerce_bloc_app/domain/auth_repository/models/models.dart';

export 'dtos/dtos.dart';
export 'models/models.dart';

part 'auth_repository.dart';

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
abstract class AuthRepository {
  /// {@macro authentication_repository}
  AuthRepository({
    CacheClient? cache,
    StreamController<UserModel>? userAuth,
  })  : _cache = cache ?? CacheClient(),
        _userAuth = userAuth ?? StreamController<UserModel>.broadcast();

  final CacheClient _cache;
  final StreamController<UserModel> _userAuth;

  /// User cache key.
  /// Should only be used for testing purposes.
  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  /// Stream of [UserModel] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [UserModel.empty] if the user is not authenticated.
  Stream<UserModel> get user async* {
    yield currentUser;
    yield* _userAuth.stream.map((user) {
      _cache.write(key: userCacheKey, value: user);
      return user;
    });
  }

  /// Returns the current cached user.
  /// Defaults to [UserModel.empty] if there is no cached user.
  UserModel get currentUser {
    return _cache.read<UserModel>(key: userCacheKey) ?? UserModel.empty;
  }

  /// id of the current user
  String? get userId => currentUser.isEmpty ? null : currentUser.id;

  bool get isAuthenticated => currentUser.isNotEmpty;

  /// Updates the user stream with the new [user].
  void updateUser(UserModel user) => _userAuth.add(user);

  Future<void> signIn(SignInDto dto);

  Future<void> signUp(SignUpDto dto);

  Future<void> signOut();

  /// disposes the _userAuth stream
  Future<void> dispose() async {
    await _userAuth.close();
    await _cache.close();
  }
}
