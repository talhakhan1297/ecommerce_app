part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.email = const Email.pure(),
    this.name = const General.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
  });

  final Email email;
  final General name;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;

  ProfileState copyWith({
    Email? email,
    General? name,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return ProfileState(
      email: email ?? this.email,
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
  List<Object?> get props => [email, name, status, isValid, errorMessage];
}

extension ProfileToState on UserModel {
  ProfileState toState() => const ProfileState().copyWith(
        email: email?.toPureEmail(),
        name: name?.toPureGeneral(),
      );
}

extension ThemeModeStyle on ThemeMode {
  IconData get icon {
    switch (this) {
      case ThemeMode.system:
        return Icons.settings_outlined;
      case ThemeMode.light:
        return Icons.light_mode_outlined;
      case ThemeMode.dark:
        return Icons.dark_mode_outlined;
    }
  }

  String get text {
    switch (this) {
      case ThemeMode.system:
        return 'System';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
    }
  }
}
