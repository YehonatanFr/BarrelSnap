import 'package:flutter/material.dart';
import 'package:BarrelSnap/models/business.dart';
import 'package:BarrelSnap/models/wines.dart';
import 'package:BarrelSnap/services/wineService.dart';
import 'package:BarrelSnap/pages/client/wines_page.dart';

// Wines Page for a Selected Business
class WinesPage extends StatelessWidget {
  final String businessId;

  const WinesPage({required this.businessId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('The winery collaction')),
      body: FutureBuilder<List<dynamic>>(
        future: WineServices.fetchWines(businessId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final business = snapshot.data![0] as BusinessModel;
            final wines = snapshot.data![1] as List<WineModel>;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Business Name: ${business.business_name}'),
                Text('Manager Name: ${business.manager_name}'),
                // Add more details of the business as needed

                SizedBox(height: 20),
                Text('Wines:'),
                Expanded(
                  child: ListView.builder(
                    itemCount: wines.length,
                    itemBuilder: (context, index) {
                      final wine = wines[index];
                      return ListTile(
                        title: Text(wine.name),
                        subtitle: Text('Price: \$${wine.price}'),
                        // You can display more details of wine if needed
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
