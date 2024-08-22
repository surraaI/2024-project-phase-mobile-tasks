import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

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
      final uri = Uri.parse(Urls.baseUrl);
      final request = http.MultipartRequest('POST', uri);

      request.fields['name'] = product.name;
      request.fields['description'] = product.description;
      request.fields['price'] = product.price.toString();

      if (product.imageUrl.isNotEmpty) {
        final imageFile = File(product.imageUrl);

        if (imageFile.existsSync()) {
          final mimeType =
              lookupMimeType(product.imageUrl) ?? 'application/octet-stream';
          final fileType = mimeType.split('/');

          request.files.add(await http.MultipartFile.fromPath(
            'image',
            product.imageUrl,
            contentType: MediaType(fileType[0], fileType[1]),
          ));
        } else {
          throw const ServerFailure('Image file does not exist');
        }
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode != 201) {
        throw ServerFailure('Failed to create product: ${response.body}');
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

      if (response.statusCode != 200) {
        throw const ServerFailure('Failed to delete product');
      }
    } catch (e) {
      throw const ConnectionFailure('Failed to connect to the server');
    }
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      //('Fetching all products from: ${Urls.baseUrl}');
      final response = await client.get(
        Uri.parse(Urls.baseUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> productList = jsonResponse['data'];
        return productList
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
    final productId = product.id;
    final jsonBody = jsonEncode({
      'name': product.name,
      'description': product.description,
      'price': product.price,
    });
    try {
      final response = await client.put(
          Uri.parse(Urls.currentProductById(productId)),
          body: jsonBody,
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode != 200) {
        throw const ServerFailure('Failed to update product');
      }
    } catch (e) {
      throw const ConnectionFailure('Failed to connect to the server');
    }
  }
}
