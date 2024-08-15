import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure,List<ProductEntity>>> getAllProducts();
  Future<Either<Failure, ProductEntity>> getProductById(String id);
  Future<void> createProduct(ProductEntity product); 
  Future<void> updateProduct(ProductEntity product); 
  Future<void> deleteProduct(String id);
}
