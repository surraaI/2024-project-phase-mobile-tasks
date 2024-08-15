import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/constants/constants.dart';
import '../../../../core/error/failure.dart';
import '../model/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> getProductById(String id);
  Future<void> createProduct(ProductModel product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(String id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<void> createProduct(ProductModel product) async {
    try {
      final response = await client.post(
        Uri.parse(Urls.baseUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(product.toJson()),
      );

      if (response.statusCode != 201) {
        throw const ServerFailure('Failed to create product');
      }
    } catch (e) {
      throw const ConnectionFailure('Failed to connect to the server');
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    try {
      final response = await client.delete(
        Uri.parse('${Urls.baseUrl}/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != 204) {
        throw const ServerFailure('Failed to delete product');
      }
    } catch (e) {
      throw const ConnectionFailure('Failed to connect to the server');
    }
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await client.get(
        Uri.parse(Urls.baseUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse
            .map((product) => ProductModel.fromJson(product))
            .toList();
      } else {
        throw const ServerFailure('Failed to load products');
      }
    } catch (e) {
      throw const ConnectionFailure('Failed to connect to the server');
    }
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    try {
      final response = await client.get(
        Uri.parse('${Urls.baseUrl}/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return ProductModel.fromJson(json.decode(response.body));
      } else {
        throw const ServerFailure('Failed to load product');
      }
    } catch (e) {
      throw const ConnectionFailure('Failed to connect to the server');
    }
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    try {
      final response = await client.put(
        Uri.parse('${Urls.baseUrl}/${product.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(product.toJson()),
      );

      if (response.statusCode != 200) {
        throw const ServerFailure('Failed to update product');
      }
    } catch (e) {
      throw const ConnectionFailure('Failed to connect to the server');
    }
  }
}
