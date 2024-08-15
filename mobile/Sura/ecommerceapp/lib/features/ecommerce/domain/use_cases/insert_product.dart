
import '../entity/product_entity.dart';
import '../repository/product_repository.dart';

class CreateProduct {
  final ProductRepository repository;

  CreateProduct({required this.repository});

  Future<void> call(ProductEntity product)  async {
    await repository.createProduct(product);
  }
}
