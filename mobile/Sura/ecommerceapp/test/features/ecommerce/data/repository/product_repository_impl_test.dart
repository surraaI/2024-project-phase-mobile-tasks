import 'package:ecommerceapp/core/platform/network_info.dart';
import 'package:ecommerceapp/features/ecommerce/data/data_sources/product_local_data_source.dart';
import 'package:ecommerceapp/features/ecommerce/data/data_sources/product_remote_data_source.dart';
import 'package:ecommerceapp/features/ecommerce/data/repository/product_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockProductLocalDataSource extends Mock implements ProductLocalDataSource {}

class MockProductRemoteDataSource extends Mock implements ProductRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late ProductRepositoryImpl repository;
  late MockProductLocalDataSource mockLocalDataSource;
  late MockProductRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockLocalDataSource = MockProductLocalDataSource();
    mockRemoteDataSource = MockProductRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ProductRepositoryImpl(
      localDataSource: mockLocalDataSource,
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

}