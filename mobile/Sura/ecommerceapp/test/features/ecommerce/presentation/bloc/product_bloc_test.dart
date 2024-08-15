import 'package:dartz/dartz.dart';
import 'package:ecommerceapp/core/error/failure.dart';
import 'package:ecommerceapp/features/ecommerce/data/repository/product_repository_impl.dart';
import 'package:ecommerceapp/features/ecommerce/domain/entity/product_entity.dart';
import 'package:ecommerceapp/features/ecommerce/presentation/bloc/product_bloc.dart';
import 'package:ecommerceapp/features/ecommerce/presentation/bloc/product_event.dart';
import 'package:ecommerceapp/features/ecommerce/presentation/bloc/product_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late ProductBloc bloc;
  late MockCreateProduct mockCreateProduct;
  late MockUpdateProduct mockUpdateProduct;
  late MockDeleteProduct mockDeleteProduct;
  late MockGetAllProducts mockGetAllProducts;
  late MockGetProductById mockGetProductById;

  setUp(() {
    mockCreateProduct = MockCreateProduct();
    mockUpdateProduct = MockUpdateProduct();
    mockDeleteProduct = MockDeleteProduct();
    mockGetAllProducts = MockGetAllProducts();
    mockGetProductById = MockGetProductById();
    bloc = ProductBloc(
      createProduct: mockCreateProduct,
      updateProduct: mockUpdateProduct,
      deleteProduct: mockDeleteProduct,
      getAllProducts: mockGetAllProducts,
      getProductById: mockGetProductById,
    );
  });

  const testProductEntity = ProductEntity(
    id: '1',
    name: 'product',
    price: 100,
    description: 'description',
    imageUrl: 'image',
  );

  const testProductEntityList = [testProductEntity];

  test('initial state should be ProductInitial', () {
    expect(bloc.state, equals(ProductInitial()));
  });

  group('LoadAllProductsEvent', () {
    test(
        'should emit [LoadingState, LoadedAllProductState] when data is gotten successfully',
        () async {
      when(mockGetAllProducts()).thenAnswer((_) async => Right([]));
      final expected = [
        LoadingState(),
        LoadedAllProductState([]),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      bloc.add(LoadAllProductsEvent());
    });

    test('should emit [LoadingState, ErrorState] when getting data fails',
        () async {
      when(mockGetAllProducts())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      final expected = [
        LoadingState(),
        ErrorState('Server Failure'),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      bloc.add(LoadAllProductsEvent());
    });
  });

  group('GetSingleProductEvent', () {
    test(
        'should emit [LoadingState, LoadedSingleProductState] when data is gotten successfully',
        () async {
      when(mockGetProductById(any))
          .thenAnswer((_) async => Right(testProductEntity));
      final expected = [
        LoadingState(),
        LoadedSingleProductState(testProductEntity),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      bloc.add(GetSingleProductEvent('1'));
    });

    test('should emit [LoadingState, ErrorState] when getting data fails',
        () async {
      when(mockGetProductById(any))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      final expected = [
        LoadingState(),
        ErrorState('Server Failure'),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      bloc.add(GetSingleProductEvent('1'));
    });
  });

  group('CreateProductEvent', () {
    test(
        'should emit [LoadingState, LoadedAllProductState] when data is created successfully',
        () async {
      when(mockCreateProduct(any))
          .thenAnswer((_) async => Right(testProductEntity));
      when(mockGetAllProducts())
          .thenAnswer((_) async => Right(testProductEntityList));
      final expected = [
        LoadingState(),
        LoadedAllProductState(testProductEntityList),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      bloc.add(CreateProductEvent(testProductEntity));
    });
  });
  group('UpdateProductEvent', () {
    test(
        'should emit [LoadingState, LoadedAllProductState] when data is updated successfully',
        () async {
      when(mockUpdateProduct(any))
          .thenAnswer((_) async => Right(testProductEntity));
      when(mockGetAllProducts())
          .thenAnswer((_) async => Right(testProductEntityList));
      final expected = [
        LoadingState(),
        LoadedAllProductState(testProductEntityList),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      bloc.add(UpdateProductEvent(testProductEntity));
    });
  });

  group('DeleteProductEvent', () {
    test(
        'should emit [LoadingState, LoadedAllProductState] when data is deleted successfully',
        () async {
      when(mockDeleteProduct(any))
          .thenAnswer((_) async => Right(testProductEntity));
      when(mockGetAllProducts())
          .thenAnswer((_) async => Right(testProductEntityList));
      final expected = [
        LoadingState(),
        LoadedAllProductState(testProductEntityList),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      bloc.add(DeleteProductEvent('1'));
    });
  });
}
