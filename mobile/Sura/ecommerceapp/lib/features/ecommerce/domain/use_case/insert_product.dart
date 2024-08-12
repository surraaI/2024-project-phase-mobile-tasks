
import '../entity/product_entity.dart';
import '../repository/product_repository.dart';

class InsertProduct {
  final ProductRepository repository;

  InsertProduct({required this.repository});

  Future<void> call(ProductEntity product)  async {
    await repository.createProduct(product);
  }
}
