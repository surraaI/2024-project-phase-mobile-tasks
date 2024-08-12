import '../entity/product_entity.dart';
import '../repository/product_repository.dart';

class UpdateProductUsecase {
  final ProductRepository repository;

  UpdateProductUsecase({required this.repository});

  Future<void> call(ProductEntity product) async {
    return await repository.updateProduct(product);
  }
}
