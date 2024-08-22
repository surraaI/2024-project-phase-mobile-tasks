import 'package:dartz/dartz.dart';
import 'package:ecommerceapp/core/error/failure.dart';
import 'package:ecommerceapp/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper/test_helper.mocks.dart';




void main() {
  late SignUpUseCase signUpUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    signUpUseCase = SignUpUseCase(mockAuthRepository);
  });

  final String tEmail = 'test@example.com';
  final String tPassword = 'password123';


group('sign up usecase', () {
  test('should call register on the repository', () async {
    // Arrange
    when(mockAuthRepository.register(any, any))
        .thenAnswer((_) async => const Right(unit));

    // Act
    final result = await signUpUseCase(tEmail, tPassword);

    // Assert
    expect(result, Right(unit));
    verify(mockAuthRepository.register(tEmail, tPassword));
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return failure when registration fails', () async {
    // Arrange
    const tFailure =  ServerFailure('server failure');
    when(mockAuthRepository.register(any, any))
        .thenAnswer((_) async => const Left(tFailure));

    // Act
    final result = await signUpUseCase(tEmail, tPassword);

    // Assert
    expect(result, Left(tFailure));
    verify(mockAuthRepository.register(tEmail, tPassword));
    verifyNoMoreInteractions(mockAuthRepository);
  });
});

}
