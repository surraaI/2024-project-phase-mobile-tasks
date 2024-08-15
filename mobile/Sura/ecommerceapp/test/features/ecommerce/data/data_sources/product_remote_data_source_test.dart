import 'dart:convert';

import 'package:ecommerceapp/core/constants/constants.dart';
import 'package:ecommerceapp/core/error/failure.dart';
import 'package:ecommerceapp/features/ecommerce/data/data_sources/product_remote_data_source.dart';
import 'package:ecommerceapp/features/ecommerce/data/model/product_model.dart';
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

  group('getAllProducts', () {
    test(
      'should perform a GET request on a URL and return a list of products when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response(fixture('products.json'), 200));
        // act
        await dataSource.getAllProducts();
        // assert
        verify(mockHttpClient.get(
          Uri.parse(Urls.baseUrl),
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
        final call = dataSource.getAllProducts;

        // assert
        expect(() => call(), throwsA(isA<ConnectionFailure>()));
      },
    );
  });

  group('createProduct', () {
    final tProductModel = ProductModel.fromJson(json.decode(fixture('product.json')));

    test(
      'should perform a POST request with the correct headers and body',
      () async {
        // arrange
        when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
            .thenAnswer((_) async => http.Response('Created', 201));
        // act
        await dataSource.createProduct(tProductModel);
        // assert
        verify(mockHttpClient.post(
          Uri.parse(Urls.baseUrl),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: json.encode(tProductModel.toJson()),
        ));
      },
    );

   test(
      'should throw connectionException error when there is no connection',
      () async {
        // arrange
        when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
            .thenThrow(Exception()); // Simulating a connection failure
        // act
        final call = dataSource.createProduct;
        // assert
        expect(() => call(tProductModel), throwsA(isA<ConnectionFailure>()));
      },
      
    );
  });

  group('updateProduct', () {
    final tProductModel = ProductModel.fromJson(json.decode(fixture('product.json')));

    test(
      'should perform a PUT request with the correct headers and body',
      () async {
        // arrange
        when(mockHttpClient.put(any, headers: anyNamed('headers'), body: anyNamed('body')))
            .thenAnswer((_) async => http.Response('Updated', 200));
        // act
        await dataSource.updateProduct(tProductModel);
        // assert
        verify(mockHttpClient.put(
          Uri.parse('${Urls.baseUrl}/${tProductModel.id}'),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: json.encode(tProductModel.toJson()),
        ));
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
            .thenAnswer((_) async => http.Response('Deleted', 204));
        // act
        await dataSource.deleteProduct(tProductId);
        // assert
        verify(mockHttpClient.delete(
          Uri.parse('${Urls.baseUrl}/$tProductId'),
          headers: {'Content-Type': 'application/json'},
        ));
      },
    );
  });

}
