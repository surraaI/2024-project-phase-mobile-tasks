import 'package:dartz/dartz.dart';
import 'package:ecommerceapp/core/error/failure.dart';
import 'package:ecommerceapp/features/auth/domain/entities/user_entity.dart';
import 'package:ecommerceapp/features/auth/domain/use_cases/get_user_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper/test_helper.mocks.dart';


void main() {
  late GetUserUseCase getUserUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    getUserUseCase = GetUserUseCase(mockAuthRepository);
  });

  const  tUser = User(email: 'test@example.com', password: 'password123');

group('get userusecase', () {
  test('should return user when getCurrentUser is successful', () async {
    // Arrange
    when(mockAuthRepository.getCurrentUser())
        .thenAnswer((_) async => const Right(tUser));

    // Act
    final result = await getUserUseCase();

    // Assert
    expect(result, Right(tUser));
    verify(mockAuthRepository.getCurrentUser());
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return failure when getCurrentUser fails', () async {
    // Arrange
    final tFailure = ServerFailure('server failure');
    when(mockAuthRepository.getCurrentUser())
        .thenAnswer((_) async => Left(tFailure));

    // Act
    final result = await getUserUseCase();

    // Assert
    expect(result, Left(tFailure));
    verify(mockAuthRepository.getCurrentUser());
    verifyNoMoreInteractions(mockAuthRepository);
  });
});
}
