import '../entity/product_entity.dart';
import '../repository/product_repository.dart';

class ViewProductUseCase {
  final ProductRepository repository;

  ViewProductUseCase({required this.repository});

  Future<ProductEntity?> call(int productId) async {
    return await repository.getProductById(productId);
  }
}
