import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:startertemplate/models/user.dart';
import 'package:startertemplate/pages/business/home_page_business.dart';
import 'package:startertemplate/pages/client/main_page_client.dart';
import 'package:startertemplate/pages/home.dart';
import 'package:provider/provider.dart';
import 'package:startertemplate/pages/login_page.dart';

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
