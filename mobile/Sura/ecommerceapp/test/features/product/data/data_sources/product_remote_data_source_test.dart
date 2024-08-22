

import 'package:ecommerceapp/core/constants/constants.dart';
import 'package:ecommerceapp/core/error/failure.dart';
import 'package:ecommerceapp/features/product/data/data_sources/product_remote_data_source.dart';
import 'package:ecommerceapp/features/product/data/model/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../helper/test_helper.mocks.dart';

void main() {
  late ProductRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = ProductRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getProductById', () {
    const tProductId = '1';

    test(
      'should perform a GET request on a URL with id being the endpoint and with application/json header',
      () {
        // arrange
        when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('product.json'), 200),
        );
        // act
        dataSource.getProductById(tProductId);
        // assert
        verify(mockHttpClient.get(
          Uri.parse('${Urls.baseUrl}/$tProductId'),
          headers: {'Content-Type': 'application/json'},
        ));
      },
    );

    test(
      'should throw ConnectionFailure when there is no connection',
      () async {
        // arrange
        when(mockHttpClient.get(any, headers: anyNamed('headers')))
            .thenThrow(Exception()); // Simulating a connection failure

        // act
        final call = dataSource.getProductById;

        // assert
        expect(() => call(tProductId), throwsA(isA<ConnectionFailure>()));
      },
    );

  });

 

  group('deleteProduct', () {
    const tProductId = '1';

    test(
      'should perform a DELETE request with the correct headers',
      () async {
        // arrange
        when(mockHttpClient.delete(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response('Deleted', 200));
        // act
        await dataSource.deleteProduct(tProductId);
        // assert
        verify(mockHttpClient.delete(
          Uri.parse('${Urls.baseUrl}/$tProductId'),
          headers: {'Content-Type': 'application/json'},
        ));
      },
    );

    test(
      'should throw ConnectionFailure when there is no connection',
      () async {
        // arrange
        when(mockHttpClient.delete(any, headers: anyNamed('headers')))
            .thenThrow(Exception()); // Simulating a connection failure

        // act
        final call = dataSource.deleteProduct;

        // assert
        expect(() => call(tProductId), throwsA(isA<ConnectionFailure>()));
      },
    );


  });

  group('getAllProducts', () {
   
    test(
      'should throw ConnectionFailure when there is no connection',
      () async {
        // arrange
        when(mockHttpClient.get(any, headers: anyNamed('headers')))
            .thenThrow(Exception()); // Simulating a connection failure

        // act
        final call = dataSource.getAllProducts;

        // assert
        expect(() => call(), throwsA(isA<ConnectionFailure>()));
      },
    );

  });

  group('createProduct', () {
    const tProductModel = ProductModel(
      id: '1',
      name: 'product',
      price: 100,
      description: 'description',
      imageUrl: 'image',
    );


    test(
      'should throw ConnectionFailure when there is no connection',
      () async {
        // arrange
        when(mockHttpClient.post(any, headers: anyNamed('headers')))
            .thenThrow(Exception()); // Simulating a connection failure

        // act
        final call = dataSource.createProduct;

        // assert
        expect(() => call(tProductModel), throwsA(isA<ConnectionFailure>()));
      },
    );

  });

  group('updateProduct', () {
    const tProductModel = ProductModel(
      id: '1',
      name: 'product',
      price: 100,
      description: 'description',
      imageUrl: 'image',
    );


    test(
      'should throw ConnectionFailure when there is no connection',
      () async {
        // arrange
        when(mockHttpClient.put(any, headers: anyNamed('headers')))
            .thenThrow(Exception()); // Simulating a connection failure

        // act
        final call = dataSource.updateProduct;

        // assert
        expect(() => call(tProductModel), throwsA(isA<ConnectionFailure>()));
      },
    );

  });

}