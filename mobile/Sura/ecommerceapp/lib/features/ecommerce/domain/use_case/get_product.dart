import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/product_entity.dart';
import '../repository/product_repository.dart';

class GetProduct {
  final ProductRepository repository;

  GetProduct({required this.repository});

  Future<Either<Failure, ProductEntity>> call(String productId) async {
    return await repository.getProductById(productId);
  }
}
