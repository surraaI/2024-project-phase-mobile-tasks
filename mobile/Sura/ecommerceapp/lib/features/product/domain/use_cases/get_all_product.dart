import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/product_entity.dart';
import '../repository/product_repository.dart';

class GetAllProducts {
  final ProductRepository repository;

  GetAllProducts({required this.repository});

  Future<Either<Failure, List<ProductEntity>>> call() async {
    return await repository.getAllProducts();
  }
}
