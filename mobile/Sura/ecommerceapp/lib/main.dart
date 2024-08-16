import 'package:flutter/material.dart';
import 'features/ecommerce/domain/entity/product_entity.dart';
import 'features/ecommerce/presentation/screens/details.dart';
import 'features/ecommerce/presentation/screens/home_page.dart';
import 'features/ecommerce/presentation/screens/search_page.dart';
import 'features/ecommerce/presentation/screens/update_page.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/searchPage': (context) => SearchPage(
              products: ModalRoute.of(context)?.settings.arguments as List<ProductEntity>,
              onDelete: (context as Map)['onDelete'],
            ),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/detailsPage') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => DetailsPage(
              product: args['product'],
              onDelete: args['onDelete'],
            ),
          );
        } else if (settings.name == '/updatePage') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => UpdatePage(
              existingProduct: args['product'],
              addProduct: args['addProduct'],
              deleteProduct: args['deleteProduct'],
            ),
          );
        }
        return null;
      },
    );
  }
}
