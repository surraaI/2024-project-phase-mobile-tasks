import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> getProductById(String id);
  Future<void> cacheProduct(ProductModel productCache);
  Future<void> cacheProducts(List<ProductModel> productCache);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;
  
  ProductLocalDataSourceImpl({required this.sharedPreferences});
  
  static const CACHED_PRODUCTS_KEY = 'CACHED_PRODUCTS';

  @override
  Future<void> cacheProduct(ProductModel productCache) {
    final jsonString = json.encode(productCache.toJson());
    return sharedPreferences.setString('${CACHED_PRODUCTS_KEY}_${productCache.id}', jsonString);
  }
  
  @override
  Future<void> cacheProducts(List<ProductModel> products) {
    for (var product in products) {
      cacheProduct(product);
    }
    return Future.value();
  }
  
  @override
  Future<List<ProductModel>> getAllProducts() async {
    final List<ProductModel> products = [];
    for (var key in sharedPreferences.getKeys()) {
      if (key.contains(CACHED_PRODUCTS_KEY)) {
        final jsonString = sharedPreferences.getString(key);
        if (jsonString != null) {
          products.add(ProductModel.fromJson(json.decode(jsonString)));
        }
      }
    }
    return products;
  }
  
  @override
  Future<ProductModel> getProductById(String id) {
    final jsonString = sharedPreferences.getString('${CACHED_PRODUCTS_KEY}_$id');
    if (jsonString != null) {
      return Future.value(ProductModel.fromJson(json.decode(jsonString)));
    } else {
      throw Exception('Product not found');
    }
  }
}
