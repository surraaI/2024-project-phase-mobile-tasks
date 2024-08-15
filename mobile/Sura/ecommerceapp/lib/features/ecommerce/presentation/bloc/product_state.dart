import 'package:equatable/equatable.dart';
import '../../domain/entity/product_entity.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}


final class ProductInitial extends ProductState {}


final class LoadingState extends ProductState {}


final class LoadedAllProductState extends ProductState {
  final List<ProductEntity> products;

  const LoadedAllProductState(this.products);

  @override
  List<Object?> get props => [products];
}


final class LoadedSingleProductState extends ProductState {
  final ProductEntity product;

  const LoadedSingleProductState(this.product);

  @override
  List<Object?> get props => [product];
}


final class ErrorState extends ProductState {
  final String message;

  const ErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
