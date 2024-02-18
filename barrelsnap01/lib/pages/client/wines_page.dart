import 'package:BarrelSnap/pages/client/client_wine_card.dart';
import 'package:flutter/material.dart';
import '/models/business.dart';
import '/models/wines.dart';
import '/services/wineService.dart';
import 'package:BarrelSnap/pages/client/client_wine_card.dart';


class WinesPage extends StatelessWidget {
  final String businessId;

  const WinesPage({required this.businessId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('The Winery Collection')),
      body: FutureBuilder<List<dynamic>>(
        future: WineServices.fetchWines(businessId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final business = snapshot.data![0] as BusinessModel;
            final wines = snapshot.data![1] as List<WineModel>;
            return SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Business Name: ${business.business_name}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Manager Name: ${business.manager_name}',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                    SizedBox(height: 4),
                    Text(
                      'Winery\'s Address: ${business.city}, ${business.street} ${business.street_number}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Winery\'s Phone: ${business.phone_number}',
                      style: TextStyle(fontSize: 16),
                    ),
                  SizedBox(height: 20),
                  Text(
                    'Wines:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: wines.map((wine) {
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
