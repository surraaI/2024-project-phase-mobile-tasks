// widgets/product_card.dart
import 'package:flutter/material.dart';
import '../../domain/entity/product_entity.dart';
import '../screens/custom_page_route.dart';
import '../screens/details.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  final Function(ProductEntity) onDelete;

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
              child: product.imageUrl != null
                  ? Image.asset(
                      product.imageUrl!,
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
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
