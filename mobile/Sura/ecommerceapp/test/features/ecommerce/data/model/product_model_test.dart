import 'dart:convert';

import 'package:ecommerceapp/features/ecommerce/data/model/product_model.dart';
import 'package:ecommerceapp/features/ecommerce/domain/entity/product_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final testProductModel = ProductModel(
    id: 1,
    name: 'test',
    description: 'bla bla',
    price: 123.0,
    category: 'shoes',
    imageUrl: 'assets/blabla.jpg',
  );

  group('test product model', () {
    test('ProductModel should be a subclass of ProductEntity', () async {
      expect(testProductModel, isA<ProductEntity>());
    });

    test(
      'should return a valid model when the JSON is given',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('product.json'));

        // act
        final result = ProductModel.fromJson(jsonMap);

        // assert
        expect(result, testProductModel);
      },
    );

    test('should return a JSON map containing the proper data', () async {
      // act
      final result = testProductModel.toJson();
      // assert
      final expectedMap = {
        'id': 1,
        'name': 'test',
        'description': 'bla bla',
        'price': 123.0,
        'category': 'shoes',
        'imageUrl': 'assets/blabla.jpg'
      };

      expect(result, expectedMap);
    });
  });
}
