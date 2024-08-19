import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/product_entity.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import '../custom_widgets/product_card.dart';
import 'custom_page_route.dart';
import 'search_page.dart';
import 'update_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(LoadAllProductsEvent());
  }

  void _navigateToUpdatePage(BuildContext context) {
    Navigator.of(context).push(
      CustomPageRoute(
        child: const UpdatePage(),
      ),
    );
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
                        child: BlocProvider.value(
                          value: context.read<ProductBloc>(),
                          child: const SearchPage(),
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
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              print(state); // Debugging state
              if (state is LoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LoadedAllProductState) {
                print(state.products); // Check if products are loaded
                return ProductList(
                  products: state.products,
                  onDelete: (product) {
                    context
                        .read<ProductBloc>()
                        .add(DeleteProductEvent(product.id));
                  },
                );
              } else if (state is ErrorState) {
                return Center(child: Text(state.message));
              } else {
                return const Center(child: Text('No Products Available'));
              }
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        onPressed: () => _navigateToUpdatePage(context),
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
          );
        },
      ),
    );
  }
}
