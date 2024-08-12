import '../entity/product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> getAllProducts();
  Future<ProductEntity?> getProductById(int id);
  Future<void> createProduct(ProductEntity product); 
  Future<void> updateProduct(ProductEntity product); 
  Future<void> deleteProduct(int id);
}
