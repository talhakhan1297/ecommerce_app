import 'package:equatable/equatable.dart';

class SignUpDto extends Equatable {
  const SignUpDto({
    required this.name,
    required this.email,
    required this.password,
  });

  final String name;
  final String email;
  final String password;

  Map<String, dynamic> toJson() =>
      {'name': name, 'email': email, 'password': password};

  @override
  List<Object?> get props => [name, email, password];
}
