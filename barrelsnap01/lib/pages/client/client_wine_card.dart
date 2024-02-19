import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/wines.dart';

class ClientWineCard extends StatelessWidget {
  final WineModel wine;

  const ClientWineCard({required this.wine});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.wine_bar),
        title: Text(wine.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Price: \$${wine.price}'),
            Text('Description: ${wine.description}'),
            if (wine.quantity < 5)
              Text(
                'Order soon! Last bottles in stock!',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            _addToCart(context);
          },
        ),
      ),
    );
  }

  void _addToCart(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add to Cart?'),
          content: Text('Are you sure you want to add this item to the cart?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                final user = FirebaseAuth.instance.currentUser;
                final customerId = user?.uid;
                if (customerId != null) {
                  _addToCartFirestore(wine, customerId);
                }
                Navigator.of(context).pop(true);
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  static Future<void> _addToCartFirestore(WineModel wine, String customerId) async {
    try {
      final cartRef = FirebaseFirestore.instance
          .collection('customer')
          .doc(customerId)
          .collection('cart');

      final existingWineQuery = await cartRef.where('Wine Name', isEqualTo: wine.name).get();
      if (existingWineQuery.docs.isNotEmpty) {
        final existingWineDoc = existingWineQuery.docs.first;
        final existingQuantity = existingWineDoc['quantity'] as int;
        await existingWineDoc.reference.update({'quantity': existingQuantity + 1});
      } else {
        await cartRef.add({
          'WineId': wine.id,
          'Wine Name': wine.name,
          'quantity': 1,
        });
      }
    } catch (e) {
      print('Error adding to cart: $e');
    }
  }
}
