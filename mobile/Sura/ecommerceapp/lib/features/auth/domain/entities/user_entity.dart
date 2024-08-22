import 'package:equatable/equatable.dart';
class User extends Equatable {
  final String email;
  final String password;
  const User({

    required this.email,
    required this.password,
  });
  @override
  List<Object?> get props => [ email, password];
 User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
  }) {
    return  User(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}