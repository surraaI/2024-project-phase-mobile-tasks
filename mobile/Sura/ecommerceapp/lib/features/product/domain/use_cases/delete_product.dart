import '../repository/product_repository.dart';

class DeleteProduct {
  final ProductRepository repository;

  DeleteProduct({required this.repository});

  Future<void> call(String id) async {
    await repository.deleteProduct(id);
  }
}
