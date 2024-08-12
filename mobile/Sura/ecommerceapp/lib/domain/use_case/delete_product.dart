import '../../domain/repository/product_repository.dart';

class DeleteProductUsecase {
  final ProductRepository repository;

  DeleteProductUsecase({required this.repository});

  Future<void> call(int id) async {
    await repository.deleteProduct(id);
  }
}
