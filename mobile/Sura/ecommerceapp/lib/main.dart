import 'package:flutter/material.dart';

import 'model/product_model.dart';
import 'presentation/screens/details.dart';
import 'presentation/screens/home_page.dart';
import 'presentation/screens/search_page.dart';
import 'presentation/screens/update_page.dart';

void main() {
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
              products: ModalRoute.of(context)?.settings.arguments as List<Product>,
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
