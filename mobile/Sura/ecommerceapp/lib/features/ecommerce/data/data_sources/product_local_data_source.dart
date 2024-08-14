import '../model/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> getProductById(int id);
  Future<void> cacheProduct(ProductModel productCache);
  Future<void> cacheProducts(List<ProductModel> productCache);
}
