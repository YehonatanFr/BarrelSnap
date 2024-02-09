import 'package:flutter/material.dart';
import 'package:startertemplate/pages/business/home_page_business.dart';
import 'package:startertemplate/pages/home.dart';

class Wrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context) {


    // return either Home - client or business, or Authenticate widget
    return Home();
  }
}