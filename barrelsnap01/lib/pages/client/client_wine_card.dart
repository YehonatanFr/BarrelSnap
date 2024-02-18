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
                _addToCartFirestore(context);
                Navigator.of(context).pop(true);
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

void _addToCartFirestore(BuildContext context) {
  final user = FirebaseAuth.instance.currentUser;
  final customerId = user?.uid;
  final cartRef = FirebaseFirestore.instance.collection('carts').doc(customerId);

  cartRef.get().then((cartSnapshot) {
    if (!cartSnapshot.exists) {
      cartRef.set({});
    }

    cartRef.collection('items').add({
      'Wine Name': wine.name,
      'quantity': 1,
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${wine.name} added to cart.'),
      ));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to add ${wine.name} to cart. Please try again.'),
      ));
    });
  });
}

}
