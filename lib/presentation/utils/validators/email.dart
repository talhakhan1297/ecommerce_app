import 'package:formz/formz.dart';
import 'package:my_ecommerce_bloc_app/presentation/l10n/l10n.dart';

enum EmailValidationError {
  empty,
  invalid;

  String message(AppLocalizations l10n) {
    switch (this) {
      case EmailValidationError.empty:
        return l10n.passwordEmpty;
      case EmailValidationError.invalid:
        return l10n.passwordLessThan8;
    }
  }
}

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure([super.value = '']) : super.pure();
  const Email.dirty([super.value = '']) : super.dirty();

  @override
  EmailValidationError? validator(String value) {
    final emailValid = RegExp(
      r'^\w+([\.-]?\w+)([+]?\w+)@\w+([\.-]?\w+)(\.\w{2,3})+$',
    ).hasMatch(value.trim());
    if (value.trim().isEmpty) {
      return EmailValidationError.empty;
    } else if (!emailValid) {
      return EmailValidationError.invalid;
    } else {
      return null;
    }
  }
}

extension EmailFromString on String {
  Email toEmail() => Email.dirty(this);
  Email toPureEmail() => Email.pure(this);
}
