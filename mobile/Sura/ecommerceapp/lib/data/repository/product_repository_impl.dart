import '../../domain/entity/product_entity.dart';
import '../../domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final List<ProductEntity> _products = [
    ProductEntity(
      id: 1,
      name: 'Derby Leathers',
      price: 120.0,
      description: 'A derby leather shoe is a classic and versatile footwear option...',
      category: 'Mens shoe',
      imageUrl: 'assets/Rectangle27.jpg',
    ),
    ProductEntity(
      id: 2,
      name: 'Classic Sneakers',
      price: 80.0,
      description: 'Comfortable and stylish, these classic sneakers are perfect for everyday wear.',
      category: 'Mens shoe',
      imageUrl: 'assets/shoe1.jpg',
    ),
  ];

  @override
  Future<List<ProductEntity>> getAllProducts() async {
    return _products;
  }

  @override
  Future<ProductEntity?> getProductById(int id) async {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> createProduct(ProductEntity product) async {
    _products.add(product);
  }

  @override
  Future<void> updateProduct(ProductEntity product) async {
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      _products[index] = product;
    } else {
      throw Exception('Product not found');
    }
  }

  @override
  Future<void> deleteProduct(int id) async {
    _products.removeWhere((product) => product.id == id);
  }
}
