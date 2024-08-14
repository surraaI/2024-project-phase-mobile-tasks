import 'package:equatable/equatable.dart';

import '../../data/model/product_model.dart';

class ProductEntity extends Equatable {
  final int id;
  String name;
  String description;
  String category;
  String imageUrl;
  double price;

  ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.price,
  });

  @override
  List<Object?> get props => [id, name, description, category, imageUrl, price];

  ProductModel toModel() {
    return ProductModel(
      id: id,
      name: name,
      description: description,
      price: price,
      category: category,
      imageUrl: imageUrl,
    );
  }
}
