import 'package:flutter/material.dart';
import 'package:BarrelSnap/models/business.dart';
import 'package:BarrelSnap/services/wineService.dart';
import 'package:BarrelSnap/pages/client/wines_page.dart';

class BusinessesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Businesses')),
      body: FutureBuilder<List<BusinessModel>>(
        future: WineServices.fetchBusinesses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final businesses = snapshot.data!;
            return ListView.builder(
              itemCount: businesses.length,
              itemBuilder: (context, index) {
                final business = businesses[index];
                return ListTile(
                  title: Text(business.business_name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WinesPage(businessId: business.uid),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
