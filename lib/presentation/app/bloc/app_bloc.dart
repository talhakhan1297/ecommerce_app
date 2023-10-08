import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/domain/auth_repository/repository.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(
          AppState(
            authStatus: authRepository.isAuthenticated
                ? AuthStatus.authenticated
                : AuthStatus.unauthenticated,
            user: authRepository.currentUser,
          ),
        ) {
    on<_AppUserChanged>(_onAppUserChanged);
    on<LogoutRequested>(_onLogoutRequested);

    _userSubscription = authRepository.user.listen(
      (user) => add(_AppUserChanged(user)),
    );
  }

  final AuthRepository _authRepository;
  late final StreamSubscription<UserModel> _userSubscription;

  @override
  Future<void> close() async {
    await _userSubscription.cancel();
    await _authRepository.dispose();
    return super.close();
  }

  void _onAppUserChanged(_AppUserChanged event, Emitter<AppState> emit) {
    emit(
      state.copyWith(
        authStatus: event.user.isNotEmpty
            ? AuthStatus.authenticated
            : AuthStatus.unauthenticated,
        user: event.user,
      ),
    );
  }

  void _onLogoutRequested(LogoutRequested event, Emitter<AppState> emit) {
    _authRepository.signOut();
  }
}
