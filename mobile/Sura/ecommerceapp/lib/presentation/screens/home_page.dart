// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../../model/product_model.dart';
import 'custom_page_route.dart';
import 'details.dart';
import 'search_page.dart';
import 'update_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> products = [
    Product(
      name: 'Derby Leathers',
      price: 120.0,
      description:
          'A derby leather shoe is a classic and versatile footwear option characterized by its open lacing system...',
      category: 'Mens shoe',
      image_path: 'assets/Rectangle27.jpg',
    ),
  ];

  void _addProduct(Product product) {
    setState(() {
      products.add(product);
    });
  }

  void _deleteProduct(Product product) {
    setState(() {
      products.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              height: 50,
              width: 50,
              color: Colors.grey,
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('2023, August 14', style: TextStyle(fontSize: 16)),
                Row(
                  children: [
                    Text('Hello, ', style: TextStyle(fontSize: 16)),
                    Text('Yohannes',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: [
          Card(
            margin: const EdgeInsets.all(10),
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: const Icon(
              Icons.notification_add,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 12.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Available Products',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      CustomPageRoute(
                        child: SearchPage(
                          products: products,
                          onDelete: _deleteProduct,
                        ),
                      ),
                    );
                  },
                  child: const Card(
                    margin: EdgeInsets.all(10),
                    shape: BeveledRectangleBorder(),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.search_outlined),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ProductList(products: products, onDelete: _deleteProduct),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.of(context).push(
            CustomPageRoute(
              child: UpdatePage(
                addProduct: _addProduct,
                deleteProduct: _deleteProduct,
              ),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
      ),
    );
  }
}


class ProductList extends StatelessWidget {
  final List<Product> products;
  final Function(Product) onDelete;

  const ProductList({
    required this.products,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: products[index],
            onDelete: onDelete,
          );
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final Function(Product) onDelete;

  const ProductCard({
    required this.product,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CustomPageRoute(
            child: DetailsPage(
              product: product,
              onDelete: onDelete,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
              child: product.image_path != null
                  ? Image.asset(
                      product.image_path!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/shoe2.jpg',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(height: 12.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${product.price.toString()}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            const SizedBox(height: 12.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.category,
                    style: const TextStyle(fontWeight: FontWeight.normal),
                  ),
                  const Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Color.fromARGB(255, 229, 255, 0),
                      ),
                      Text(
                        '4.0',
                        style: TextStyle(fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
