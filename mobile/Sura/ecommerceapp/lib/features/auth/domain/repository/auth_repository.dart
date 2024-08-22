import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> login(String email, String password);
  Future<Either<Failure, Unit>> register(String email, String password);
  Future<Either<Failure, User>> getCurrentUser();
  Future<Either<Failure, Unit>> logout();
}


