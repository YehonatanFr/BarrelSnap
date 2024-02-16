import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:BarrelSnap/models/wines.dart';

class WineServices {
  static Future<void> addWine(WineModel wine, String businessId) async {
    try {
      await FirebaseFirestore.instance.collection('business').doc(businessId).collection('wines').add({
        'name': wine.name,
        'kindOfGrape': wine.kindOfGrape,
        'description': wine.description,
        'price': wine.price,
        'quantity': wine.quantity,
      });
    } catch (e) {
      throw e;
    }
  }

  static Future<void> updateWine(WineModel wine, String businessId, String wineId) async {
    try {
      await FirebaseFirestore.instance.collection('business').doc(businessId).collection('wines').doc(wineId).update({
        'name': wine.name,
        'kindOfGrape': wine.kindOfGrape,
        'description': wine.description,
        'price': wine.price,
        'quantity': wine.quantity,
      });
    } catch (e) {
      throw e;
    }
  }

  static Future<void> deleteWine(String businessId, String wineId) async {
    try {
      await FirebaseFirestore.instance.collection('business').doc(businessId).collection('wines').doc(wineId).delete();
    } catch (e) {
      throw e;
    }
  }

  static Future<List<WineModel>> getBusinessWines(String businessId) async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('business').doc(businessId).collection('wines').get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return WineModel(
          id: doc.id, // Adding the id field
          name: data['name'] ?? '',
          kindOfGrape: data['kindOfGrape'] ?? '',
          description: data['description'] ?? '',
          price: data['price'] ?? 0,
          quantity: data['quantity'] ?? 0,
        );
      }).toList();
    } catch (e) {
      throw e;
    }
  }

  static Future<void> updateWineQuantity(String wineId, String businessId, int newQuantity) async {
    try {
      await FirebaseFirestore.instance.collection('business').doc(businessId).collection('wines').doc(wineId).update({
        'quantity': newQuantity,
      });
    } catch (e) {
      throw e;
    }
  }
}
