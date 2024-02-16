import 'package:flutter/material.dart';
import 'package:BarrelSnap/models/wines.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:BarrelSnap/services/wineService.dart';

class WineCard extends StatelessWidget {
  final WineModel wine;
  final Function() onUpdate;

  const WineCard({required this.wine, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(wine.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Price: \$${wine.price}'),
            Text('Quantity: ${wine.quantity}'),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () {
            _showUpdateQuantityDialog(context, wine);
          },
          child: Text('Update Quantity'),
        ),
      ),
    );
  }

  void _showUpdateQuantityDialog(BuildContext context, WineModel wine) {
    TextEditingController _quantityController = TextEditingController(text: '${wine.quantity}');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Quantity'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      int currentQuantity = int.parse(_quantityController.text);
                      if (currentQuantity > 0) {
                        _quantityController.text = '${currentQuantity - 1}';
                      }
                    },
                    child: Text('-'),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _quantityController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'New Quantity'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the new quantity';
                        }
                        int newQuantity = int.parse(value);
                        if (newQuantity < 0) {
                          return 'Quantity cannot be less than 0';
                        }
                        return null;
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      int currentQuantity = int.parse(_quantityController.text);
                      _quantityController.text = '${currentQuantity + 1}';
                    },
                    child: Text('+'),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _updateQuantity(context, wine, int.parse(_quantityController.text));
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _updateQuantity(BuildContext context, WineModel wine, int newQuantity) {
    final user = FirebaseAuth.instance.currentUser;
    final String businessId = user?.uid ?? '';
    WineServices.updateWineQuantity(wine.id, businessId, newQuantity).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Quantity updated successfully'),
      ));
      // Call the onUpdate callback to update the UI in the parent widget
      onUpdate();
      Navigator.of(context).pop(); // Close the dialog
    }).catchError((error) {
      print('Error updating quantity: $error');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to update quantity. Please try again.'),
      ));
    });
  }
}
