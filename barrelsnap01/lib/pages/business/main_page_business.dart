import 'package:flutter/material.dart';
import '/components/my_bottom_nav_bar.dart';
import '/components/my_drawer.dart';
import 'home_page_business.dart';
import 'profile_page_business.dart';
import 'shop_page_business.dart';

class MainPageBusiness extends StatefulWidget {
  const MainPageBusiness({super.key});

  @override
  State<MainPageBusiness> createState() => _MainPageState();
}

class _MainPageState extends State<MainPageBusiness> {
  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const HomePageBusiness(),
    const ShopPageBusiness(),
    const ProfilePageBusiness(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.grey.shade800,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text(
          'A P P',
          style: TextStyle(color: Colors.grey.shade800),
        ),
      ),
      drawer: MyDrawer(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
    );
  }
}
