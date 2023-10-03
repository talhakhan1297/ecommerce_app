part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.name = const General.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
  });

  final Email email;
  final Password password;
  final General name;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;

  SignUpState copyWith({
    Email? email,
    Password? password,
    General? name,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  String? nameError(AppLocalizations l10n) {
    if (name.displayError == GeneralValidationError.empty) {
      return l10n.nameEmpty;
    }
    return null;
  }

  @override
  List<Object?> get props => [
        email,
        password,
        name,
        status,
        isValid,
        errorMessage,
      ];
}
