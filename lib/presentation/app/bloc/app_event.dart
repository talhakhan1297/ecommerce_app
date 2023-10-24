part of 'app_bloc.dart';

class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class _AppUserChanged extends AppEvent {
  const _AppUserChanged(this.user);

  final UserModel user;
}

class LogoutRequested extends AppEvent {}

class ToggleThemeModeRequested extends AppEvent {
  const ToggleThemeModeRequested({required this.themeMode});

  final ThemeMode themeMode;

  @override
  List<Object> get props => [themeMode];
}
