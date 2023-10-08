import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:ecommerce_app/common/custom_exception.dart';
import 'package:ecommerce_app/domain/auth_repository/repository.dart';
import 'package:ecommerce_app/presentation/utils/validators/validators.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const SignInState()) {
    on<SignInEmailChanged>(_onEmailChanged);
    on<SignInPasswordChanged>(_onPasswordChanged);
    on<SignInFormSubmitted>(_onFormSubmitted);
  }

  final AuthRepository _authRepository;

  void _onEmailChanged(SignInEmailChanged event, Emitter<SignInState> emit) {
    final email = Email.dirty(event.email);

    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email, state.password]),
      ),
    );
  }

  void _onPasswordChanged(
    SignInPasswordChanged event,
    Emitter<SignInState> emit,
  ) {
    final password = Password.dirty(event.password);

    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([state.email, password]),
      ),
    );
  }

  Future<void> _onFormSubmitted(
    SignInFormSubmitted event,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    try {
      await _authRepository.signIn(
        SignInDto(
          email: state.email.value,
          password: state.password.value,
        ),
      );

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
