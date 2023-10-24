part of 'profile_bloc.dart';

class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileNameChanged extends ProfileEvent {
  const ProfileNameChanged({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}

class ProfileEmailChanged extends ProfileEvent {
  const ProfileEmailChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class ProfileFormSubmitted extends ProfileEvent {}
