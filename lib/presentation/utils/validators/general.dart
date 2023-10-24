import 'package:formz/formz.dart';

enum GeneralValidationError { empty }

class General extends FormzInput<String, GeneralValidationError> {
  const General.pure([super.value = '']) : super.pure();
  const General.dirty([super.value = '']) : super.dirty();

  @override
  GeneralValidationError? validator(String value) {
    return value.trim().isEmpty ? GeneralValidationError.empty : null;
  }

  bool get isEmpty => error == GeneralValidationError.empty;

  bool get isNotEmpty => error == null;
}

extension GeneralFromString on String {
  General toGeneral() => General.dirty(this);
  General toPureGeneral() => General.pure(this);
}
