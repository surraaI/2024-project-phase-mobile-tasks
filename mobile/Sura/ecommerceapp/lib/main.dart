import 'package:ecommerceapp/details.dart';
import 'package:ecommerceapp/home_page.dart';
import 'package:ecommerceapp/update_page.dart';
import 'package:flutter/material.dart';

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
        '/': (BuildContext context) => const HomePage(),
        '/details': (BuildContext context) => const DetailsPage(),
        '/updates': (BuildContext context) => const UpdatePage(),
      },
    );
  }
}
