import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/common/custom_exception.dart';
import 'package:ecommerce_app/domain/auth_repository/repository.dart';
import 'package:ecommerce_app/presentation/l10n/l10n.dart';
import 'package:ecommerce_app/presentation/utils/validators/validators.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required AuthRepository authRepository,
    ProfileState? state,
  })  : _authRepository = authRepository,
        super(state ?? const ProfileState()) {
    on<ProfileNameChanged>(_onNameChanged);
    on<ProfileEmailChanged>(_onEmailChanged);
    on<ProfileFormSubmitted>(_onFormSubmitted);
  }

  final AuthRepository _authRepository;

  void _onNameChanged(ProfileNameChanged event, Emitter<ProfileState> emit) {
    final name = General.dirty(event.name);

    emit(
      state.copyWith(
        name: name,
        isValid: Formz.validate([name, state.email]),
      ),
    );
  }

  void _onEmailChanged(ProfileEmailChanged event, Emitter<ProfileState> emit) {
    final email = Email.dirty(event.email);

    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([state.name, email]),
      ),
    );
  }

  Future<void> _onFormSubmitted(
    ProfileFormSubmitted event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    try {
      await _authRepository.updateProfile();

      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on CustomException catch (e) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorMessage: e.message,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
