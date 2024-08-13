import '../model/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getAllProducts();

  Future<void> cacheProduct(ProductModel productCache);
}