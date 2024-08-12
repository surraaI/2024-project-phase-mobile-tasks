class ProductEntity {
  final int id;
   String name;
   String description;
   String category;
   String imageUrl;
   double price;

  ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.price,
  });

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price)';
  }
}
