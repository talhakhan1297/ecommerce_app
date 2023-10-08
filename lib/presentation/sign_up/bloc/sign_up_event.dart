part of 'sign_up_bloc.dart';

class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpNameChanged extends SignUpEvent {
  const SignUpNameChanged({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}

class SignUpEmailChanged extends SignUpEvent {
  const SignUpEmailChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class SignUpPasswordChanged extends SignUpEvent {
  const SignUpPasswordChanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class SignUpFormSubmitted extends SignUpEvent {}
