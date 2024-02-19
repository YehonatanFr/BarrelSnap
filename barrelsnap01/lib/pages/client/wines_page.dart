import 'package:flutter/material.dart';
import '/models/business.dart';
import '/models/wines.dart';
import '/services/wineService.dart';
import 'package:BarrelSnap/pages/client/client_wine_card.dart';

class WinesPage extends StatelessWidget {
  final String businessId;

  const WinesPage({super.key, required this.businessId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('The Winery Collection')),
      body: FutureBuilder<List<dynamic>>(
        future: WineServices.fetchWines(businessId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final business = snapshot.data![0] as BusinessModel;
            final wines = snapshot.data![1] as List<WineModel>;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Business Name: ${business.business_name}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Manager Name: ${business.manager_name}',
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Winery\'s Address: ${business.city}, ${business.street} ${business.street_number}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Winery\'s Phone: ${business.phone_number}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Wines:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: wines
                        .where((wine) => wine.quantity > 0)
                        .map((wine) {
                      return ClientWineCard(wine: wine);
                    }).toList(),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
