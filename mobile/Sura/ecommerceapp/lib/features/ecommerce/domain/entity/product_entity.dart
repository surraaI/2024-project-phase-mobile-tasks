import 'package:equatable/equatable.dart';

import '../../data/model/product_model.dart';

class ProductEntity extends Equatable {
  final String id;
  String name;
  String description;
  String imageUrl;
  double price;

  ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
  });

  @override
  List<Object?> get props => [id, name, description, imageUrl, price];

  ProductModel toModel() {
    return ProductModel(
      id: id,
      name: name,
      description: description,
      price: price,
      imageUrl: imageUrl,
    );
  }
}
