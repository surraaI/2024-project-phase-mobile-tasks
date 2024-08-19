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

  const cachedProductsKey = 'CACHED_PRODUCTS';
  
  final tProductModel = ProductModel.fromJson(json.decode(fixture('product.json')));
  final tProductId = tProductModel.id.toString();
  final tProductModels = [tProductModel, tProductModel];
  final expectedJsonString = json.encode(tProductModel.toJson());

  String getCacheKey(String id) => '${cachedProductsKey}_$id';

  group('getProductById', () {
    void arrangeSharedPreferencesWithProduct() {
      when(mockSharedPreferences.getString(getCacheKey(tProductId)))
          .thenReturn(fixture('product.json'));
    }

    test(
      'should return Product from SharedPreferences when there is one in the cache',
      () async {
        // arrange
        arrangeSharedPreferencesWithProduct();

        // act
        final result = await dataSource.getProductById(tProductId);

        // assert
        verify(mockSharedPreferences.getString(getCacheKey(tProductId)));
        expect(result, equals(tProductModel));
      },
    );

    test(
      'should throw an Exception when there is no cached data',
      () async {
        // arrange
        when(mockSharedPreferences.getString(getCacheKey(tProductId)))
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
          getCacheKey(tProductId), expectedJsonString))
          .thenAnswer((_) async => true);

        // act
        await dataSource.cacheProduct(tProductModel);

        // assert
        verify(mockSharedPreferences.setString(
          getCacheKey(tProductId), expectedJsonString));
      },
    );
  });

  group('getAllProducts', () {
    void arrangeSharedPreferencesWithProducts() {
      when(mockSharedPreferences.getKeys()).thenReturn({
        getCacheKey('1'),
        getCacheKey('2'),
      });
      when(mockSharedPreferences.getString(getCacheKey('1')))
          .thenReturn(fixture('product.json'));
      when(mockSharedPreferences.getString(getCacheKey('2')))
          .thenReturn(fixture('product.json'));
    }

    test(
      'should return a list of ProductModels from SharedPreferences when there are cached products',
      () async {
        // arrange
        arrangeSharedPreferencesWithProducts();

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
