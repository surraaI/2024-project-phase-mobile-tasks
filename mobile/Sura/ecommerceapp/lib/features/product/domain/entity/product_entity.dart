import 'package:equatable/equatable.dart';

import '../../data/model/product_model.dart';

class ProductEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;

  const ProductEntity({
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

  ProductEntity copyWith({
    String? id,
    String? name,
    double? price,
    String? description,
    String? imageUrl,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
