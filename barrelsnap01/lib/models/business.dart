import 'package:cloud_firestore/cloud_firestore.dart';

class BusinessModel {
  final String uid;
  final String business_name;
  final String manager_name;
  final DateTime? birthdate;
  final String? phone_number;
  final String? city;
  final String? street;
  final String? street_number;


  BusinessModel({
    required this.uid,
    required this.business_name,
    required this.manager_name,
    this.birthdate,
    this.phone_number,
    this.city,
    this.street,
    this.street_number,

  });

  factory BusinessModel.fromSnapshot(QueryDocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return BusinessModel(
      uid: doc.id,
      business_name: data['business_name'] ?? '',
      manager_name: data['manager_name'] ?? '',
      birthdate: data['birthdate'] ?? '',
      phone_number: data['phone_number'] ?? '',
      city: data['city'] ?? '',
      street: data['street'] ?? '',
      street_number: data['street_number'] ?? '',
    );
  }
}
