// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import '../../domain/entity/product_entity.dart';
import '../custom_widgets/product_card.dart';
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
  List<ProductEntity> products = [
    const ProductEntity(
      name: 'Derby Leathers',
      price: 120.0,
      description:
          'A derby leather shoe is a classic and versatile footwear option characterized by its open lacing system...',
      imageUrl: 'assets/Rectangle27.jpg',
      id: '1',
    ),
  ];

  void _addProduct(ProductEntity product) {
    setState(() {
      products.add(product);
    });
  }

  void _deleteProduct(ProductEntity product) {
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
  final List<ProductEntity> products;
  final Function(ProductEntity) onDelete;

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

