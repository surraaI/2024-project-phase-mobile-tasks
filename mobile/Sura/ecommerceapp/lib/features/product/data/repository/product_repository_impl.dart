import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entity/product_entity.dart';
import '../../domain/repository/product_repository.dart';
import '../data_sources/product_local_data_source.dart';
import '../data_sources/product_remote_data_source.dart';
import '../model/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource localDataSource;
  final ProductRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<void> createProduct(ProductEntity product) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.createProduct(product.toModel());
      } on ServerException {
        throw const Left(ServerFailure('server failure'));
      } on SocketException {
        throw const Left( ConnectionFailure('Connection Failed'));
      }
    } else {
      throw const Left(ConnectionFailure('Connection Failed'));
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteProduct(id);
      } on ServerException {
        throw const Left(ServerFailure('server failure'));
      } on SocketException {
        throw const Left(ConnectionFailure('Connection Failed'));
      }
    } else {
      throw const Left(ConnectionFailure('server failure'));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getAllProducts();
        localDataSource.cacheProducts(remoteProducts);
        return Right(remoteProducts);
      } on ServerException {
        return const Left(ServerFailure('server failure'));
      } on SocketException {
        return const Left(ConnectionFailure('Connection Failed'));
      }
    } else {
      try {
        final localProducts = await localDataSource.getAllProducts();
        return Right(localProducts);
      } on CacheException {
        return const Left(CacheFailure('cache failure'));
      }
    }
  }

  @override
  Future<Either<Failure, ProductModel>> getProductById(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await remoteDataSource.getProductById(id);
        localDataSource.cacheProduct(remoteProduct);
        return Right(remoteProduct);
      } on ServerException {
        return const Left(ServerFailure('server failure'));
      } on SocketException {
        return const Left(ConnectionFailure('Connection Failed'));
      }
    } else {
      try {
        final localProduct = await localDataSource.getProductById(id);
        return Right(localProduct);
      } on CacheException {
        return const Left(CacheFailure('cache failure'));
      }
    }
  }

  @override
  Future<void> updateProduct(ProductEntity product) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.updateProduct(product.toModel());
      } on ServerException {
        throw const Left(ServerFailure('server failure'));
      } on SocketException {
        throw const Left(ConnectionFailure('Connection Failed'));
      }
    } else {
      throw const Left(ConnectionFailure('Connection Failed'));
    }
  }
}
