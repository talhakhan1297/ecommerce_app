import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/common/custom_exception.dart';
import 'package:ecommerce_app/domain/auth_repository/repository.dart';
import 'package:ecommerce_app/presentation/l10n/l10n.dart';
import 'package:ecommerce_app/presentation/utils/validators/validators.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const SignUpState()) {
    on<SignUpNameChanged>(_onNameChanged);
    on<SignUpEmailChanged>(_onEmailChanged);
    on<SignUpPasswordChanged>(_onPasswordChanged);
    on<SignUpFormSubmitted>(_onFormSubmitted);
  }

  final AuthRepository _authRepository;

  void _onNameChanged(SignUpNameChanged event, Emitter<SignUpState> emit) {
    final name = General.dirty(event.name);

    emit(
      state.copyWith(
        name: name,
        isValid: Formz.validate([name, state.email, state.password]),
      ),
    );
  }

  void _onEmailChanged(SignUpEmailChanged event, Emitter<SignUpState> emit) {
    final email = Email.dirty(event.email);

    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([state.name, email, state.password]),
      ),
    );
  }

  void _onPasswordChanged(
    SignUpPasswordChanged event,
    Emitter<SignUpState> emit,
  ) {
    final password = Password.dirty(event.password);

    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([state.name, state.email, password]),
      ),
    );
  }

  Future<void> _onFormSubmitted(
    SignUpFormSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    try {
      await _authRepository.signUp(
        SignUpDto(
          name: state.name.value,
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
