import 'dart:io';
import 'Product.dart';

class ProductManager {
  List<Product> products = [];

  void listOfActions() {
    while (true) {
      stdout.writeln('Choose an action:');
      stdout.writeln('1: Add new product');
      stdout.writeln('2: View all products');
      stdout.writeln('3: View a single product');
      stdout.writeln('4: Edit a product');
      stdout.writeln('5: Delete a product');
      stdout.writeln('6: Exit');

      var action = stdin.readLineSync();
      switch (action) {
        case '1':
          addNewProduct();
          break;
        case '2':
          viewAllProducts();
          break;
        case '3':
          viewSingleProduct();
          break;
        case '4':
          editProduct();
          break;
        case '5':
          deleteProduct();
          break;
        case '6':
          return;
        default:
          stdout.writeln('Invalid action. Please try again.');
      }
    }
  }

  void addNewProduct() {
    stdout.write("Enter product name: ");
    var name = stdin.readLineSync();

    stdout.write("Enter product description: ");
    var description = stdin.readLineSync();

    stdout.write("Enter product price: ");
    var price = int.tryParse(stdin.readLineSync() ?? '');

    if (name != null && description != null && price != null) {
      var newProduct = Product(name: name, description: description, price: price);
      products.add(newProduct);
      stdout.writeln("Product added successfully.");
    } else {
      stdout.writeln("Invalid input. Product not added.");
    }
  }

  void viewAllProducts() {
    if (products.isEmpty) {
      stdout.writeln("No products available.");
    } else {
      for (var i = 0; i < products.length; i++) {
        stdout.writeln("Product $i: ${products[i].name}, ${products[i].description}, \$${products[i].price}");
      }
    }
  }

  void viewSingleProduct() {
    stdout.write("Enter product index: ");
    var index = int.tryParse(stdin.readLineSync() ?? '');

    if (index != null && index >= 0 && index < products.length) {
      var product = products[index];
      stdout.writeln("Product $index: ${product.name}, ${product.description}, \$${product.price}");
    } else {
      stdout.writeln("Invalid index.");
    }
  }

  void editProduct() {
    stdout.write("Enter product index to edit: ");
    var index = int.tryParse(stdin.readLineSync() ?? '');

    if (index != null && index >= 0 && index < products.length) {
      var product = products[index];

      stdout.write("Enter new name (current: ${product.name}): ");
      var name = stdin.readLineSync();

      stdout.write("Enter new description (current: ${product.description}): ");
      var description = stdin.readLineSync();

      stdout.write("Enter new price (current: ${product.price}): ");
      var price = int.tryParse(stdin.readLineSync() ?? '');

      if (name != null && name.isNotEmpty) product.name = name;
      if (description != null && description.isNotEmpty) product.description = description;
      if (price != null) product.price = price;

      stdout.writeln("Product updated successfully.");
    } else {
      stdout.writeln("Invalid index.");
    }
  }

  void deleteProduct() {
    stdout.write("Enter product index to delete: ");
    var index = int.tryParse(stdin.readLineSync() ?? '');

    if (index != null && index >= 0 && index < products.length) {
      products.removeAt(index);
      stdout.writeln("Product deleted successfully.");
    } else {
      stdout.writeln("Invalid index.");
    }
  }
}

void main() {
  var productManager = ProductManager();
  productManager.listOfActions();
}
