
import '../entity/product_entity.dart';
import '../repository/product_repository.dart';

class CreateProductUseCase {
  final ProductRepository repository;

  CreateProductUseCase({required this.repository});

  Future<void> call(ProductEntity product)  async {
    await repository.createProduct(product);
  }
}
