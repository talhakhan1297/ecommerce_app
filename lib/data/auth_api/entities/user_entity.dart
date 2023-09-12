import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({this.id, this.name, this.email});

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
    );
  }

  final String? id;
  final String? name;
  final String? email;

  @override
  List<Object?> get props => [id, name, email];
}
