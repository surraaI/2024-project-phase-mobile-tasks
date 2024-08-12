
// ignore_for_file: non_constant_identifier_names

class Product {
  String name;
  double price;
  String description;
  String category;
  String? image_path;
  double? rating;

  Product({
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    this.image_path,
    this.rating,
  });
}
