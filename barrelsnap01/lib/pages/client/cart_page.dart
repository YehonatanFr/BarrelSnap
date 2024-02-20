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
                  _placeOrder(context, customerId);
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
  
void _placeOrder(BuildContext context, String customerId) async {
  try {
    // Get cart items
    final cartItems = await FirebaseFirestore.instance
        .collection('customer')
        .doc(customerId)
        .collection('cart')
        .get();

    // Iterate over cart items
    for (final item in cartItems.docs) {
      final wineId = item.data()['WineId'];

      // Get the businesses that sell this wine
      final businessesQuery = await FirebaseFirestore.instance
          .collection('business')
          .where('wines.$wineId', isEqualTo: true)
          .get();

      // Check if any business sells this wine
      if (businessesQuery.docs.isEmpty) {
        print('Error: No business sells the wine with ID $wineId');
        continue; // Skip to the next item in the cart
      }

      // Iterate over each business that sells this wine
      for (final businessDoc in businessesQuery.docs) {
        final businessId = businessDoc.id;

        // Get the wine details from the business's wine collection
        final wineDoc = await FirebaseFirestore.instance
            .collection('business')
            .doc(businessId)
            .collection('wines')
            .doc(wineId)
            .get();

        // Check if the wine document exists
        if (!wineDoc.exists) {
          print('Error: Wine with ID $wineId not found in the wine collection of business $businessId');
          continue; // Skip to the next business
        }

        // Create order data
        final orderData = {
          'customerId': customerId,
          'wineName': wineDoc['name'],
          'quantity': item.data()['quantity'],
          'timestamp': DateTime.now(),
          // Add other order details as needed
        };

        // Create order document within business collection
        await FirebaseFirestore.instance
            .collection('business')
            .doc(businessId)
            .collection('orders')
            .add(orderData);
      }
    }

    // Clear the user's cart after placing orders
    await _clearCart(customerId);

    // Show a success message or navigate to order history
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Orders placed successfully!'),
    ));
  } catch (e) {
    print('Error placing orders: $e');
    // Handle error appropriately
  }
}






  // Function to clear the user's cart
  Future<void> _clearCart(String customerId) async {
    try {
      final cartItems = await FirebaseFirestore.instance
          .collection('customer')
          .doc(customerId)
          .collection('cart')
          .get();

      // Delete each item from the cart
      for (final item in cartItems.docs) {
        await item.reference.delete();
      }
    } catch (e) {
      print('Error clearing cart: $e');
      // Handle error appropriately
    }
  }
}
