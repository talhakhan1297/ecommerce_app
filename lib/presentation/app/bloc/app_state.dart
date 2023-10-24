part of 'app_bloc.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AppState extends Equatable {
  const AppState({
    this.authStatus = AuthStatus.unknown,
    this.user = UserModel.empty,
    this.themeMode = ThemeMode.system,
  });

  final AuthStatus authStatus;
  final UserModel user;
  final ThemeMode themeMode;

  AppState copyWith({
    AuthStatus? authStatus,
    UserModel? user,
    ThemeMode? themeMode,
  }) {
    return AppState(
      authStatus: authStatus ?? this.authStatus,
      user: user ?? this.user,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  bool get isAuthenticated => authStatus == AuthStatus.authenticated;

  bool get isUnauthenticated => !isAuthenticated;

  @override
  List<Object?> get props => [authStatus, user, themeMode];
}
