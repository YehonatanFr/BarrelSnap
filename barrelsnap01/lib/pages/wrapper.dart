import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:BarrelSnap/models/wines.dart';
import 'package:BarrelSnap/pages/business/home_page_business.dart';
import 'package:BarrelSnap/pages/client/main_page_client.dart';
import 'package:provider/provider.dart';
import 'package:BarrelSnap/pages/login_page.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if (user == null) {
      return LoginPage();
    } else {
      return MainPageClient();
    } // return either Home - client or business, or Authenticate widget
  }
}