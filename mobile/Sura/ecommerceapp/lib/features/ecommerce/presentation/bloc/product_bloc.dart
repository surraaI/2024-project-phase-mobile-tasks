import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entity/product_entity.dart';
import '../../domain/use_cases/create_product.dart';
import '../../domain/use_cases/delete_product.dart';
import '../../domain/use_cases/get_all_product.dart';
import '../../domain/use_cases/get_product.dart';
import '../../domain/use_cases/update_product.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final CreateProduct createProduct;
  final UpdateProduct updateProduct;
  final DeleteProduct deleteProduct;
  final GetProductById getProductById;
  final GetAllProducts getAllProducts;

  ProductBloc({
    required this.createProduct,
    required this.updateProduct,
    required this.deleteProduct,
    required this.getProductById,
    required this.getAllProducts,
  }) : super(ProductInitial()) {
    on<LoadAllProductsEvent>(_onLoadAllProducts);
    on<GetSingleProductEvent>(_onGetSingleProduct);
    on<CreateProductEvent>(_onCreateProduct);
    on<UpdateProductEvent>(_onUpdateProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
  }

  Future<void> _onLoadAllProducts(
      LoadAllProductsEvent event, Emitter<ProductState> emit) async {
    emit(LoadingState());
    final Either<Failure, List<ProductEntity>> result = await getAllProducts();
    result.fold(
      (failure) => emit(ErrorState(_mapFailureToMessage(failure))),
      (products) => emit(LoadedAllProductState(products)),
    );
  }

  Future<void> _onGetSingleProduct(
      GetSingleProductEvent event, Emitter<ProductState> emit) async {
    emit(LoadingState());
    final Either<Failure, ProductEntity> result =
        await getProductById(event.productId);
    result.fold(
      (failure) => emit(ErrorState(_mapFailureToMessage(failure))),
      (product) => emit(LoadedSingleProductState(product)),
    );
  }

  Future<void> _onCreateProduct(
      CreateProductEvent event, Emitter<ProductState> emit) async {
    emit(LoadingState());
    try {
      await createProduct(event.product); 
      add(LoadAllProductsEvent()); 
    } catch (e) {
      emit(ErrorState(_mapErrorToMessage(e))); 
    }
  }

  Future<void> _onUpdateProduct(
      UpdateProductEvent event, Emitter<ProductState> emit) async {
    emit(LoadingState());
    try {
      await updateProduct(event.product); 
      add(LoadAllProductsEvent()); 
    } catch (e) {
      emit(ErrorState(_mapErrorToMessage(e))); 
    }
  }

  Future<void> _onDeleteProduct(
      DeleteProductEvent event, Emitter<ProductState> emit) async {
    emit(LoadingState());
    try {
      await deleteProduct(event.productId); 
      add(LoadAllProductsEvent()); 
    } catch (e) {
      emit(ErrorState(_mapErrorToMessage(e))); 
    }
  }

  
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      case CacheFailure:
        return 'Cache Failure';
      default:
        return 'Unexpected Error';
    }
  }

  
  String _mapErrorToMessage(dynamic error) {
    if (error is Failure) {
      return _mapFailureToMessage(error);
    } else {
      return 'Unexpected Error';
    }
  }
}
