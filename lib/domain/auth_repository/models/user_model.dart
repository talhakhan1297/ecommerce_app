import 'package:equatable/equatable.dart';
import 'package:my_ecommerce_bloc_app/data/auth_api/entities/entities.dart';

class UserModel extends Equatable {
  const UserModel({this.id, this.name, this.email});

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
    );
  }

  static const empty = UserModel(id: '0', name: '-', email: '-');

  bool get isEmpty => id == '0';

  bool get isNotEmpty => !isEmpty;

  final String? id;
  final String? name;
  final String? email;

  @override
  List<Object?> get props => [id, name, email];
}
