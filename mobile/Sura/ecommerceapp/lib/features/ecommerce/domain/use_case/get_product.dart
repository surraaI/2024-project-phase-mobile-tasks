import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../entity/product_entity.dart';
import '../repository/product_repository.dart';

class GetProduct {
  final ProductRepository repository;

  GetProduct({required this.repository});

  Future<Either<Failure, ProductEntity>> call(int productId) async {
    return await repository.getProductById(productId);
  }
}
