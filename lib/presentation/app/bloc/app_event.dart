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
