import 'package:dartz/dartz.dart';
import 'package:ecommerceapp/core/error/exception.dart';
import 'package:ecommerceapp/core/error/failure.dart';
import 'package:ecommerceapp/features/ecommerce/data/model/product_model.dart';
import 'package:ecommerceapp/features/ecommerce/data/repository/product_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../helper/test_helper.mocks.dart';

void main() {
  late ProductRepositoryImpl repository;
  late MockProductLocalDataSource mockLocalDataSource;
  late MockProductRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  const tProduct = ProductModel(
    id: '1',
    name: 'Product 1',
    description: 'Product 1 description',
    price: 100,
    imageUrl: 'https://via.placeholder.com/150',
  );
  final List<ProductModel> tProductList = [tProduct];

  setUp(() {
    mockLocalDataSource = MockProductLocalDataSource();
    mockRemoteDataSource = MockProductRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ProductRepositoryImpl(
      localDataSource: mockLocalDataSource,
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );

    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
  });

  group('createProduct', () {
    test(
        'should create product when the call to remote data source is successful',
        () async {
      // act
      await repository.createProduct(tProduct);
      // assert
      verify(mockRemoteDataSource.createProduct(tProduct));
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.createProduct(any))
          .thenThrow(ServerException());
      // act
      final call = repository.createProduct(tProduct);
      // assert
      expect(() => call, throwsA(isA<Left<ServerFailure, void>>()));
    });

    test(
        'should return connection failure when the device is offline',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      // act
      final call = repository.createProduct(tProduct);
      // assert
      expect(() => call, throwsA(isA<Left<ConnectionFailure, void>>()));
    });
  });

  group('deleteProduct', () {
    test(
        'should delete product when the call to remote data source is successful',
        () async {
      // act
      await repository.deleteProduct(tProduct.id);
      // assert
      verify(mockRemoteDataSource.deleteProduct(tProduct.id));
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.deleteProduct(any))
          .thenThrow(ServerException());
      // act
      final call = repository.deleteProduct(tProduct.id);
      // assert
      expect(() => call, throwsA(isA<Left<ServerFailure, void>>()));
    });

    test(
        'should return connection failure when the device is offline',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      // act
      final call = repository.deleteProduct(tProduct.id);
      // assert
      expect(() => call, throwsA(isA<Left<ConnectionFailure, void>>()));
    });
  });

  group('getAllProducts', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getAllProducts())
          .thenAnswer((_) async => tProductList);
      // act
      final result = await repository.getAllProducts();
      // assert
      verify(mockRemoteDataSource.getAllProducts());
      expect(result, equals(Right(tProductList)));
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getAllProducts()).thenThrow(ServerException());
      // act
      final result = await repository.getAllProducts();
      // assert
      verify(mockRemoteDataSource.getAllProducts());
      expect(result, equals(const Left(ServerFailure('server failure'))));
    });

    test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getAllProducts())
          .thenAnswer((_) async => tProductList);
      // act
      await repository.getAllProducts();
      // assert
      verify(mockRemoteDataSource.getAllProducts());
      verify(mockLocalDataSource.cacheProducts(tProductList));
    });

    test(
        'should return local data when the device is offline',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockLocalDataSource.getAllProducts())
          .thenAnswer((_) async => tProductList);
      // act
      final result = await repository.getAllProducts();
      // assert
      verify(mockLocalDataSource.getAllProducts());
      expect(result, equals(Right(tProductList)));
    });

    test(
        'should return cache failure when the call to local data source is unsuccessful',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockLocalDataSource.getAllProducts()).thenThrow(CacheException());
      // act
      final result = await repository.getAllProducts();
      // assert
      verify(mockLocalDataSource.getAllProducts());
      expect(result, equals(const Left(CacheFailure('cache failure'))));
    });
  });

  group('updateProduct', () {
    test(
        'should update product when the call to remote data source is successful',
        () async {
      // act
      await repository.updateProduct(tProduct);
      // assert
      verify(mockRemoteDataSource.updateProduct(tProduct));
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.updateProduct(any))
          .thenThrow(ServerException());
      // act
      final call = repository.updateProduct(tProduct);
      // assert
      expect(() => call, throwsA(isA<Left<ServerFailure, void>>()));
    });

    test(
        'should return connection failure when the device is offline',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      // act
      final call = repository.updateProduct(tProduct);
      // assert
      expect(() => call, throwsA(isA<Left<ConnectionFailure, void>>()));
    });
  });
}
