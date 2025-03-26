import 'package:flutter/material.dart';

void main() {
  runApp(ShoppingApp());
}

class ShoppingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping Cart',
      home: ProductListScreen(),
    );
  }
}

class Product {
  String name;
  double price;

  Product(this.name, this.price);
}

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> products = [
    Product("Apple", 1.5),
    Product("Banana", 1.0),
    Product("Orange", 2.0),
    Product("Mango", 3.5),
    Product("Grapes", 2.8),
  ];

  List<Product> cart = [];

  void addToCart(Product product) {
    setState(() {
      cart.add(product);
    });
  }

  void showCart(BuildContext context) {
    double total = cart.fold(0, (sum, item) => sum + item.price);
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Shopping Cart"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children:
                  cart
                      .map((item) => Text("${item.name} - \$${item.price}"))
                      .toList(),
            ),
            actions: [
              Text("Total: \$${total.toStringAsFixed(2)}"),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Close"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product List")),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].name),
            subtitle: Text("\$${products[index].price}"),
            trailing: ElevatedButton(
              onPressed: () => addToCart(products[index]),
              child: Text("Add"),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showCart(context),
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}
