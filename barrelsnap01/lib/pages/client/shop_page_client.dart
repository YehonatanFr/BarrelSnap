import 'package:flutter/material.dart';
import 'package:BarrelSnap/models/business.dart';
import 'package:BarrelSnap/services/wineService.dart';
import 'package:BarrelSnap/pages/client/wines_page.dart';

class ClientShopPage extends StatefulWidget {
  @override
  _ClientShopPageState createState() => _ClientShopPageState();
}

class _ClientShopPageState extends State<ClientShopPage> {
  late List<BusinessModel> _businesses;
  late List<BusinessModel> _filteredBusinesses = [];

  @override
  void initState() {
    super.initState();
    _fetchBusinesses();
  }

  Future<void> _fetchBusinesses() async {
    final businesses = await WineServices.fetchBusinesses();
    setState(() {
      _businesses = businesses;
      _filteredBusinesses = businesses;
    });
  }

  void _filterBusinesses(String query) {
    setState(() {
      _filteredBusinesses = _businesses
          .where((business) =>
              business.business_name.toLowerCase().contains(query.toLowerCase()) ||
              business.manager_name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search by business name or manager',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _filterBusinesses,
            ),
          ),
          Expanded(
            child: _buildBusinessList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessList() {
    return _filteredBusinesses.isEmpty
        ? Center(child: Text('No businesses found'))
        : ListView.builder(
            itemCount: _filteredBusinesses.length,
            itemBuilder: (context, index) {
              final business = _filteredBusinesses[index];
              return BusinessCard(
                business: business,
                icon: Icons.business,
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
}

class BusinessCard extends StatelessWidget {
  final BusinessModel business;
  final IconData icon;
  final VoidCallback onTap;

  const BusinessCard({required this.business, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                icon,
                size: 40,
                color: Colors.blue,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      business.business_name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Manager: ${business.manager_name}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Location: ${business.city}, ${business.street} ${business.street_number}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
