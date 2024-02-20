import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:BarrelSnap/models/order.dart';

class OrdersPage extends StatelessWidget {
  final String customerId;

  OrdersPage({required this.customerId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Last Orders'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('customer')
            .doc(customerId)
            .collection('orders')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text('You have no orders yet.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final order = OrderModel.fromMap(snapshot.data!.docs[index].data() as Map<String, dynamic>);
                return OrderCard(order: order);
              },
            );
          }
        },
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        leading: Icon(Icons.receipt),
        title: Text(order.wineName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Quantity: ${order.quantity}'),
            Text('Ordered on: ${order.timestamp.toDate().toString()}'),
            Text('Business: ${order.businessName}'),
          ],
        ),
      ),
    );
  }
}

