import 'package:flutter/material.dart';
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
            if (wine.quantity < 5)
              Text(
                'Order soon! Last bottles in stock!',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
