import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/model/product_model.dart';


class UpdatePage extends StatefulWidget {
  final Function(Product)? addProduct;
  final Function(Product)? deleteProduct; 
  final Product? existingProduct;  

  const UpdatePage({
    this.addProduct, 
    this.deleteProduct, 
    this.existingProduct, 
    super.key
  });

  @override
  // ignore: library_private_types_in_public_api
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  String? imagePath;
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.existingProduct != null) {
      _nameController.text = widget.existingProduct!.name;
      _categoryController.text = widget.existingProduct!.category;
      _priceController.text = widget.existingProduct!.price.toString();
      _descriptionController.text = widget.existingProduct!.description;
      imagePath = widget.existingProduct!.image_path;
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }

  void _onAddProduct() {
  if (_nameController.text.isEmpty ||
      _categoryController.text.isEmpty ||
      _priceController.text.isEmpty ||
      _descriptionController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please fill in all fields')),
    );
    return;
  }

  final String name = _nameController.text;
  final String category = _categoryController.text;
  final double price = double.parse(_priceController.text);
  final String description = _descriptionController.text;

  if (widget.existingProduct != null) {
    // Update existing product
    widget.existingProduct!.name = name;
    widget.existingProduct!.category = category;
    widget.existingProduct!.price = price;
    widget.existingProduct!.description = description;
    widget.existingProduct!.image_path = imagePath;

    Navigator.pop(context);
  } else {
    // Create a new product
    final Product newProduct = Product(
      image_path: imagePath,
      name: name,
      price: price,
      description: description,
      category: category,
    );

    widget.addProduct!(newProduct);
    Navigator.pop(context);
  }
}
  

  void _onDeleteProduct() {
    if (widget.existingProduct != null) {
      widget.deleteProduct!(widget.existingProduct!); 
    }
    Navigator.pop(context);
  }

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
        title: Text(widget.existingProduct != null ? 'Edit Product' : 'Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: imagePath == null
                      ? const Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image),
                            Text('Upload Image'),
                          ],
                        ))
                      : kIsWeb
                          ? Image.network(imagePath!, fit: BoxFit.cover)
                          : Image.file(File(imagePath!), fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text('Name'),
              const SizedBox(height: 8.0),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text('Category'),
              const SizedBox(height: 8.0),
              TextField(
                controller: _categoryController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text('Price'),
              const SizedBox(height: 8.0),
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text('Description'),
              const SizedBox(height: 8.0),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _onAddProduct,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Add Product'),
                  ),
                ),
              ),
              if (widget.existingProduct != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _onDeleteProduct,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Delete Product'),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}