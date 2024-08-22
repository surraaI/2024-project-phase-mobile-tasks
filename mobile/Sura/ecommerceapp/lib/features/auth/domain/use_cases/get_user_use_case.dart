import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';
import '../repository/auth_repository.dart';

class GetUserUseCase {
  final AuthRepository _authRepository;

  GetUserUseCase(this._authRepository);

  Future<Either<Failure, User>> call() async {
    return await _authRepository.getCurrentUser();
  }
}