import 'package:ecommerceapp/core/network/network_info.dart';
import 'package:ecommerceapp/features/ecommerce/data/data_sources/product_local_data_source.dart';
import 'package:ecommerceapp/features/ecommerce/data/data_sources/product_remote_data_source.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([ProductLocalDataSource, ProductRemoteDataSource, NetworkInfo, InternetConnectionChecker])

void main() {}