import 'package:ecommerceapp/details.dart'; 
import 'package:ecommerceapp/search_page.dart';
import 'package:ecommerceapp/update_page.dart'; 
import 'package:flutter/material.dart'; 

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                    Text("Hello, ", style: TextStyle(fontSize: 16)),
                    Text('Yohannes', style: TextStyle(fontWeight: FontWeight.bold)
                    )
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
                  "Available Products",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SearchPage()));
                  },
                  child: const Card(
                    margin: EdgeInsets.all(10),
                    shape: BeveledRectangleBorder(),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.search_outlined),
                    ),
                  ),
                )
              ],
            ),
          ),
          const ProductList(count: 7),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: CircleBorder(),
        onPressed: () => {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => UpdatePage()))
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
  final int count;

  const ProductList({
    required this.count,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: count,
        itemBuilder: (context, index) {
          return const ProductCard();
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const DetailsPage()));
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
              child: Image.asset(
                'assets/Rectangle27.jpg',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Derby Leathers",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\$120",
                    style: TextStyle(fontWeight: FontWeight.bold),
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
                  Text(
                    "Mens shoe",
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Color.fromARGB(255, 229, 255, 0),
                      ),
                      Text(
                        "4.0",
                        style: TextStyle(fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


