import 'package:equatable/equatable.dart';

class SignInDto extends Equatable {
  const SignInDto({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}
