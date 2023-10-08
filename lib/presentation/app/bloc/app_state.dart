part of 'app_bloc.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AppState extends Equatable {
  const AppState({
    this.authStatus = AuthStatus.unknown,
    this.user = UserModel.empty,
  });

  final AuthStatus authStatus;
  final UserModel user;

  AppState copyWith({AuthStatus? authStatus, UserModel? user}) {
    return AppState(
      authStatus: authStatus ?? this.authStatus,
      user: user ?? this.user,
    );
  }

  bool get isAuthenticated => authStatus == AuthStatus.authenticated;

  bool get isUnauthenticated => !isAuthenticated;

  @override
  List<Object?> get props => [authStatus, user];
}
