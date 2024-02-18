import 'package:BarrelSnap/models/wines.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final customerId = currentUser?.uid ?? '';

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'My Cart',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('customer')
                  .doc(customerId)
                  .collection('cart')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('Your cart is empty.'));
                } else {
                  return ListView(
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      final data = document.data() as Map<String, dynamic>;
                      final WineName = data['Wine Name'];
                      final quantity = data['quantity'];

                      // TODO: Fetch wine details using wineId and display them

                      return ListTile(
                        title: Text('Wine Name: $WineName'),
                        subtitle: Text('Quantity: $quantity'),
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> addToCart(BuildContext context, WineModel wine, String customerId) async {
  final cartRef = FirebaseFirestore.instance.collection('customer').doc(customerId).collection('cart');

  try {
    await cartRef.add({
      'wineId': wine.id,
      'quantity': wine.quantity,
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Item added to cart.'),
    ));
  } catch (e) {
    rethrow;
  }
}
