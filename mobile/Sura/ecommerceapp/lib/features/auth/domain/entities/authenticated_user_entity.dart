import 'package:equatable/equatable.dart';

class AuthenticatedUserEntity extends Equatable {
  
  // token is returned from the server
  final String token;

  const AuthenticatedUserEntity({
    required this.token,
  });

  @override
  List<Object?> get props => [token];

}