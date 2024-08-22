import 'package:dartz/dartz.dart';
import 'package:ecommerceapp/core/error/failure.dart';
import 'package:ecommerceapp/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper/test_helper.mocks.dart';




void main() {
  late LogoutUseCase logoutUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    logoutUseCase = LogoutUseCase(mockAuthRepository);
  });

group('logout usecase', () {
  test('should call logout on the repository', () async {
    // Arrange
    when(mockAuthRepository.logout())
        .thenAnswer((_) async => const Right(unit));

    // Act
    final result = await logoutUseCase();

    // Assert
    expect(result, const Right(unit));
    verify(mockAuthRepository.logout());
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return failure when logout fails', () async {
    // Arrange
    final tFailure = ServerFailure('server failure');
    when(mockAuthRepository.logout())
        .thenAnswer((_) async => Left(tFailure));

    // Act
    final result = await logoutUseCase();

    // Assert
    expect(result, Left(tFailure));
    verify(mockAuthRepository.logout());
    verifyNoMoreInteractions(mockAuthRepository);
  });
});
}
