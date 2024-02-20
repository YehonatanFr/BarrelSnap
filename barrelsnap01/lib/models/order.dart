import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String wineName;
  final int quantity;
  final Timestamp timestamp;
  final String businessName;

  OrderModel({
    required this.wineName,
    required this.quantity,
    required this.timestamp,
    required this.businessName,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      wineName: map['wineName'],
      quantity: map['quantity'],
      timestamp: map['timestamp'],
      businessName: map['businessName'],
    );
  }
}
