// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_bloc.dart';
import '../bloc/product_state.dart';
import '../custom_widgets/product_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchQuery = '';
  double _minPrice = 0;
  double _maxPrice = 1000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Search Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      suffixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                        // _filterProducts();
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.filter_list,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Category',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onChanged: (value) {
                                   
                                  },
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    const Text('Price:'),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: RangeSlider(
                                        values:
                                            RangeValues(_minPrice, _maxPrice),
                                        min: 0,
                                        max: 1000,
                                        divisions: 100,
                                        labels: RangeLabels(
                                          '\$${_minPrice.round()}',
                                          '\$${_maxPrice.round()}',
                                        ),
                                        onChanged: (RangeValues values) {
                                          setState(() {
                                            _minPrice = values.start;
                                            _maxPrice = values.end;
                                          });
                                        },
                                        activeColor: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    // _filterProducts();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(50),
                                    backgroundColor: Colors.blue,
                                  ),
                                  child: const Text(
                                    'APPLY',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is LoadedAllProductState) {
                    final filteredProducts = state.products.where((product) {
                      final isWithinPriceRange = product.price >= _minPrice &&
                          product.price <= _maxPrice;
                      final matchesSearchQuery = product.name
                              .toLowerCase()
                              .contains(_searchQuery.toLowerCase()) ||
                          product.description
                              .toLowerCase()
                              .contains(_searchQuery.toLowerCase());
                      return isWithinPriceRange && matchesSearchQuery;
                    }).toList();

                    return ListView.builder(
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          product: filteredProducts[index],
                        );
                      },
                    );
                  } else if (state is ErrorState) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return const Center(child: Text('No products available'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void _filterProducts() {
  //   context.read<ProductBloc>().add(
  //         FilterProductsEvent(
  //           searchQuery: _searchQuery,
  //           minPrice: _minPrice,
  //           maxPrice: _maxPrice,
  //           category: _category,
  //         ),
  //       );
  // }
}
