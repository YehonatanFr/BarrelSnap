import 'package:BarrelSnap/pages/client/order_page_client.dart';
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
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final document = snapshot.data!.docs[index];
                      final data = document.data() as Map<String, dynamic>;
                      final wineName = data['Wine Name'];
                      final quantity = data['quantity'];

                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              const Icon(Icons.wine_bar),
                              const SizedBox(width: 8),
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
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  _decrementQuantity(customerId, document.id);
                                },
                              ),
                              Text(quantity.toString()),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  _incrementQuantity(customerId, document.id);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
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
              child: Column(
                children: [
                  const Divider(),
                  ElevatedButton(
                    onPressed: () {
                      _placeOrder(context, customerId);
                    },
                    child: const Text('Place Order'),
                  ),
                  const SizedBox(height: 8),
                  const Divider(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrdersPage(customerId: customerId),
                        ),
                      );
                    },
                    child: const Text('My Last orders'),
                  ),
                ],
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

void _placeOrder(BuildContext context, String customerId) async {
  try {
    final cartItems = await FirebaseFirestore.instance
        .collection('customer')
        .doc(customerId)
        .collection('cart')
        .get();


    final allBusinesses = await FirebaseFirestore.instance
        .collection('business')
        .get();

    String? foundBusinessId;

    for (final item in cartItems.docs) {
      final wineId = item.data()['WineId'];

      bool wineFound = false;
      for (final businessDoc in allBusinesses.docs) {
        final businessId = businessDoc.id;

        final winesCollection = await FirebaseFirestore.instance
            .collection('business')
            .doc(businessId)
            .collection('wines')
            .get();

        for (final wineDoc in winesCollection.docs) {
          if (wineDoc.id == wineId) {
            wineFound = true;
            foundBusinessId = businessId;

            final orderData = {
              'customerId': customerId,
              'wineName': wineDoc['name'],
              'quantity': item.data()['quantity'],
              'timestamp': DateTime.now(),
              'businessName': businessDoc['business_name'],
            };

            await FirebaseFirestore.instance
                .collection('business')
                .doc(businessId)
                .collection('orders')
                .add(orderData);

           await FirebaseFirestore.instance
                .collection('customer')
                .doc(customerId)
                .collection('orders')
                .add(orderData);
            break;
          }
        }

        if (wineFound) {
          break;
        }
      }

      if (!wineFound) {
        print('Error: No business sells the wine with ID $wineId');
      }
    }

    if (foundBusinessId != null) {
      await _clearCart(customerId);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Orders placed successfully!'),
      ));
    }
  } catch (e) {
    print('Error placing orders: $e');
  }
}



  Future<void> _clearCart(String customerId) async {
    try {
      final cartItems = await FirebaseFirestore.instance
          .collection('customer')
          .doc(customerId)
          .collection('cart')
          .get();

      for (final item in cartItems.docs) {
        await item.reference.delete();
      }
    } catch (e) {
      print('Error clearing cart: $e');
    }
  }
}
