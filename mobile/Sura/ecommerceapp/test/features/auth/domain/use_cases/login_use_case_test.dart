import 'package:dartz/dartz.dart';
import 'package:ecommerceapp/core/error/failure.dart';
import 'package:ecommerceapp/features/auth/domain/use_cases/login_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late LoginUseCase loginUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    loginUseCase = LoginUseCase(mockAuthRepository);
  });

  final String tEmail = 'email@nj.com';
  final String tPassword = 'password';

group('login usecase', () {
  test('should call login on the repository', () async {
    // Arrange
    when(mockAuthRepository.login(any, any))
        .thenAnswer((_) async => Right(unit));

    // Act
    final result = await loginUseCase(tEmail, tPassword);

    // Assert
    expect(result, Right(unit));
    verify(mockAuthRepository.login(tEmail, tPassword));
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return failure when login fails', () async {
    // Arrange
    final tFailure = ServerFailure('server failure');
    when(mockAuthRepository.login(any, any))
        .thenAnswer((_) async => Left(tFailure));

    // Act
    final result = await loginUseCase(tEmail, tPassword);

    // Assert
    expect(result, Left(tFailure));
    verify(mockAuthRepository.login(tEmail, tPassword));
    verifyNoMoreInteractions(mockAuthRepository);
  });
});
}
