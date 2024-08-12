import '../entity/product_entity.dart';
import '../repository/product_repository.dart';

class ViewAllProductsUseCase {
  final ProductRepository repository;

  ViewAllProductsUseCase({required this.repository});

  Future<List<ProductEntity>> call() async {
    return await repository.getAllProducts();
  }
}
