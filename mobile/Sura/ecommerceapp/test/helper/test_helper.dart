import 'package:ecommerceapp/core/network/network_info.dart';
import 'package:ecommerceapp/features/ecommerce/data/data_sources/product_local_data_source.dart';
import 'package:ecommerceapp/features/ecommerce/data/data_sources/product_remote_data_source.dart';
import 'package:ecommerceapp/features/ecommerce/domain/use_cases/delete_product.dart';
import 'package:ecommerceapp/features/ecommerce/domain/use_cases/get_all_product.dart';
import 'package:ecommerceapp/features/ecommerce/domain/use_cases/get_product.dart';
import 'package:ecommerceapp/features/ecommerce/domain/use_cases/create_product.dart';
import 'package:ecommerceapp/features/ecommerce/domain/use_cases/update_product.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks(
  [
    ProductLocalDataSource,
    ProductRemoteDataSource,
    NetworkInfo,
    InternetConnectionChecker,
    SharedPreferences,
    DeleteProduct,
    GetAllProducts,
    GetProductById,
    CreateProduct,
    UpdateProduct,
  ],
  customMocks: [
    MockSpec<http.Client>(as: #MockHttpClient),
  ],
)
void main() {}
