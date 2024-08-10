import 'package:ecommerceapp/presentation/screens/home_page.dart';
import 'package:ecommerceapp/model/product_model.dart'; 
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  final List<Product> products;
  final Function(Product) onDelete;

  const SearchPage({
    Key? key, 
    required this.products,
    required this.onDelete,
  }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchQuery = '';
  double _minPrice = 0;
  double _maxPrice = 1000;
  String _category = '';

  @override
  Widget build(BuildContext context) {
    List<Product> filteredProducts = widget.products.where((product) {
      final isWithinPriceRange = product.price >= _minPrice && product.price <= _maxPrice;
      final matchesCategory = _category.isEmpty || product.category.toLowerCase().contains(_category.toLowerCase());
      final matchesSearchQuery = product.name.toLowerCase().contains(_searchQuery.toLowerCase()) || product.description.toLowerCase().contains(_searchQuery.toLowerCase());
      return isWithinPriceRange && matchesCategory && matchesSearchQuery;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Search Product"),
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
                                    setState(() {
                                      _category = value;
                                    });
                                  },
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    const Text("Price:"),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: RangeSlider(
                                        values: RangeValues(_minPrice, _maxPrice),
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
              child: ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: filteredProducts[index],
                    onDelete: widget.onDelete,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
