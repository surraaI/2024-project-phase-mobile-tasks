import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/ecommerce/data/data_sources/product_local_data_source.dart';
import 'features/ecommerce/data/data_sources/product_remote_data_source.dart';
import 'features/ecommerce/data/repository/product_repository_impl.dart';
import 'features/ecommerce/domain/repository/product_repository.dart';
import 'features/ecommerce/domain/use_cases/create_product.dart';
import 'features/ecommerce/domain/use_cases/delete_product.dart';
import 'features/ecommerce/domain/use_cases/get_all_product.dart';
import 'features/ecommerce/domain/use_cases/get_product.dart';
import 'features/ecommerce/domain/use_cases/update_product.dart';
import 'features/ecommerce/presentation/bloc/product_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
   sl.registerFactory(() => ProductBloc(
         createProduct: sl(),
         updateProduct: sl(),
         deleteProduct: sl(),
         getProductById: sl(),
         getAllProducts: sl(),
       ));

  // Use cases
   sl.registerLazySingleton(() => CreateProduct(repository: sl()));
   sl.registerLazySingleton(() => UpdateProduct(repository: sl()));
   sl.registerLazySingleton(() => DeleteProduct(repository: sl()));
   sl.registerLazySingleton(() => GetProductById(repository: sl()));
   sl.registerLazySingleton(() => GetAllProducts(repository: sl()));

  // Repository
   sl.registerLazySingleton<ProductRepository>(
     () => ProductRepositoryImpl(
       localDataSource: sl(),
       remoteDataSource: sl(),
       networkInfo: sl(),
     ),
   );

  // Data sources
   sl.registerLazySingleton<ProductRemoteDataSource>(
     () => ProductRemoteDataSourceImpl(client: sl()),
   );

   sl.registerLazySingleton<ProductLocalDataSource>(
     () => ProductLocalDataSourceImpl(sharedPreferences: sl()),
   );

  // Core
   sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}