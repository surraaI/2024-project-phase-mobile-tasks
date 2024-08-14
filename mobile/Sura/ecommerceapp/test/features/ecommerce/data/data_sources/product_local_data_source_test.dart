import 'dart:convert';

import 'package:ecommerceapp/features/ecommerce/data/data_sources/product_local_data_source.dart';
import 'package:ecommerceapp/features/ecommerce/data/model/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../fixtures/fixture_reader.dart';
import '../../../../helper/test_helper.mocks.dart';

void main() {
  late ProductLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = ProductLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  const CACHED_PRODUCTS_KEY = 'CACHED_PRODUCTS';
  final tProductModel =
      ProductModel.fromJson(json.decode(fixture('product.json')));
  final tProductId = tProductModel.id.toString();
  final tProductModels = [tProductModel, tProductModel];
  final expectedJsonString = json.encode(tProductModel.toJson());

  group('getProductById', () {
    test(
      'should return Product from SharedPreferences when there is one in the cache',
      () async {
        // arrange
        when(mockSharedPreferences
                .getString('${CACHED_PRODUCTS_KEY}_$tProductId'))
            .thenReturn(fixture('product.json'));
        // act
        final result = await dataSource.getProductById(tProductId);
        // assert
        verify(mockSharedPreferences
            .getString('${CACHED_PRODUCTS_KEY}_$tProductId'));
        expect(result, equals(tProductModel));
      },
    );

    test(
      'should throw an Exception when there is no cached data',
      () async {
        // arrange
        when(mockSharedPreferences
                .getString('${CACHED_PRODUCTS_KEY}_$tProductId'))
            .thenReturn(null);
        // act
        final call = dataSource.getProductById;
        // assert
        expect(() => call(tProductId), throwsA(isA<Exception>()));
      },
    );
  });

  group('cacheProduct', () {
    test(
      'should call SharedPreferences to cache the data',
      () async {
        // arrange
        when(mockSharedPreferences.setString(
                '${CACHED_PRODUCTS_KEY}_$tProductId', expectedJsonString))
            .thenAnswer((_) async => true);

        // act
        await dataSource.cacheProduct(tProductModel);

        // assert
        verify(mockSharedPreferences.setString(
            '${CACHED_PRODUCTS_KEY}_$tProductId', expectedJsonString));
      },
    );
  });

  group('getAllProducts', () {
    test(
      'should return a list of ProductModels from SharedPreferences when there are cached products',
      () async {
        // arrange
        when(mockSharedPreferences.getKeys()).thenReturn({
          '${CACHED_PRODUCTS_KEY}_1',
          '${CACHED_PRODUCTS_KEY}_2',
        });
        when(mockSharedPreferences.getString('${CACHED_PRODUCTS_KEY}_1'))
            .thenReturn(fixture('product.json'));
        when(mockSharedPreferences.getString('${CACHED_PRODUCTS_KEY}_2'))
            .thenReturn(fixture('product.json'));

        // act
        final result = await dataSource.getAllProducts();

        // assert
        verify(mockSharedPreferences.getKeys());
        expect(result, equals(tProductModels));
      },
    );

    test(
      'should return an empty list when there are no cached products',
      () async {
        // arrange
        when(mockSharedPreferences.getKeys()).thenReturn({});

        // act
        final result = await dataSource.getAllProducts();

        // assert
        expect(result, isEmpty);
      },
    );
  });

}
