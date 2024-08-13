import '../../../../core/platform/network_info.dart';
import '../../domain/entity/product_entity.dart';
import '../../domain/repository/product_repository.dart';
import '../data_sources/product_local_data_source.dart';
import '../data_sources/product_remote_data_source.dart';
import '../model/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource localDataSource;
  final ProductRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;


  ProductRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,}
  );
  @override
  Future<void> createProduct(ProductEntity product) {
    // TODO: implement createProduct
    throw UnimplementedError();
  }
  
  @override
  Future<void> deleteProduct(int id) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }
  
  @override
  Future<List<ProductModel>> getAllProducts() {
    networkInfo.isConnected;
    // TODO: implement getAllProducts
    throw UnimplementedError();
  }
  
  @override
  Future<ProductModel?> getProductById(int id) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }
  
  @override
  Future<void> updateProduct(ProductEntity product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }
  
}