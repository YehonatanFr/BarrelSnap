import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/wines.dart';

class ClientWineCard extends StatelessWidget {
  final WineModel wine;

  const ClientWineCard({super.key, required this.wine});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
      leading: wine.imageUrl.isNotEmpty
          ? Image.network(wine.imageUrl, width: 60, height: 60,)
          : const SizedBox(
        width: 60,
        height: 60,
        child: Icon(Icons.wine_bar),
          ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${wine.name}', style: const TextStyle(fontWeight: FontWeight.bold),),
            Text('Description: ${wine.description}'),
            Text('Price: \$${wine.price}'),
            if (wine.quantity < 5)
              const Text(
                'Order soon! Last bottles in stock!',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.shopping_cart),
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
          title: const Text('Add to Cart?'),
          content: const Text('Are you sure you want to add this item to the cart?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('No'),
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
              child: const Text('Yes'),
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
