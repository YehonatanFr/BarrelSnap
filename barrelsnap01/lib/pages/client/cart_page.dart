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
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('Your cart is empty.'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final document = snapshot.data!.docs[index];
                      final data = document.data() as Map<String, dynamic>;
                      final wineName = data['Wine Name'];
                      final quantity = data['quantity'];

                      return Card(
                        margin: EdgeInsets.all(8),
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Icon(Icons.wine_bar),
                              SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('$wineName'),
                                    Text('Quantity: $quantity'),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  _decrementQuantity(customerId, document.id);
                                },
                              ),
                              Text(quantity.toString()),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  _incrementQuantity(customerId, document.id);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  _removeFromCart(customerId, document.id);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  _placeOrder(customerId);
                },
                child: Text('Place Order'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _removeFromCart(String customerId, String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('customer')
          .doc(customerId)
          .collection('cart')
          .doc(documentId)
          .delete();
    } catch (e) {
      print('Error removing item from cart: $e');
    }
  }

  void _incrementQuantity(String customerId, String documentId) async {
    try {
      final document = await FirebaseFirestore.instance
          .collection('customer')
          .doc(customerId)
          .collection('cart')
          .doc(documentId)
          .get();

      if (document.exists) {
        final currentQuantity = document.data()?['quantity'] ?? 0;
        await FirebaseFirestore.instance
            .collection('customer')
            .doc(customerId)
            .collection('cart')
            .doc(documentId)
            .update({'quantity': currentQuantity + 1});
      }
    } catch (e) {
      print('Error incrementing quantity: $e');
    }
  }

  void _decrementQuantity(String customerId, String documentId) async {
    try {
      final document = await FirebaseFirestore.instance
          .collection('customer')
          .doc(customerId)
          .collection('cart')
          .doc(documentId)
          .get();

      if (document.exists) {
        final currentQuantity = document.data()?['quantity'] ?? 0;

        if (currentQuantity == 1) {
          _removeFromCart(customerId, documentId);
        } else if (currentQuantity > 0) {
          await FirebaseFirestore.instance
              .collection('customer')
              .doc(customerId)
              .collection('cart')
              .doc(documentId)
              .update({'quantity': currentQuantity - 1});
        }
      }
    } catch (e) {
      print('Error decrementing quantity: $e');
    }
  }

  void _placeOrder(String customerId) async {
    try {
      // Here you can implement the logic to place the order
      // For example, you can move items from the cart to an orders collection
      // and then clear the cart collection for this user

      // Step 1: Get the cart items
      final cartItems = await FirebaseFirestore.instance
          .collection('customer')
          .doc(customerId)
          .collection('cart')
          .get();

      // Step 2: Add the cart items to the orders collection
      final ordersCollection = FirebaseFirestore.instance
          .collection('customer')
          .doc(customerId)
          .collection('orders');

      for (final item in cartItems.docs) {
        await ordersCollection.add(item.data());
      }

      // Step 3: Clear the cart collection
      await FirebaseFirestore.instance
          .collection('customer')
          .doc(customerId)
          .collection('cart')
          .get()
          .then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs) {
          ds.reference.delete();
        }
      });

      print('Order placed successfully');
    } catch (e) {
      print('Error placing order: $e');
    }
  }
}
