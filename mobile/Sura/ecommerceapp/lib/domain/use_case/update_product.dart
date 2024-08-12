import '../entity/product_entity.dart';
import '../repository/product_repository.dart';

class UpdateProduct {
  final ProductRepository repository;

  UpdateProduct({required this.repository});

  Future<void> call(ProductEntity product) async {
    return await repository.updateProduct(product);
  }
}
