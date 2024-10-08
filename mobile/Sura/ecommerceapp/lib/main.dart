import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/product/domain/entity/product_entity.dart';
import 'features/product/presentation/bloc/product_bloc.dart';
import 'features/product/presentation/bloc/product_event.dart';
import 'features/product/presentation/pages/details_page.dart';
import 'features/product/presentation/pages/home_page.dart';
import 'features/product/presentation/pages/search_page.dart';
import 'features/product/presentation/pages/update_page.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<ProductBloc>()..add(LoadAllProductsEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
        },
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/searchPage':
              return MaterialPageRoute(
                builder: (context) => const SearchPage(),
              );
            case '/detailsPage':
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                builder: (context) => DetailsPage(
                  product: args['product'] as ProductEntity,
                ),
              );
            case '/updatePage':
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                builder: (context) => UpdatePage(
                  existingProduct: args['product'] as ProductEntity?,
                ),
              );
            default:
              return null;
          }
        },
      ),
    );
  }
}
