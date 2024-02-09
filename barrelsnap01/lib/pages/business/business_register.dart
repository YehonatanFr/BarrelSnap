import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart'; 

class BusinessSignIn extends StatefulWidget {
  @override
  _BusinessSignInState createState() => _BusinessSignInState();
}

class _BusinessSignInState extends State<BusinessSignIn> {
  final businessNameController = TextEditingController();
  final managerNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final cityController = TextEditingController();
  final streetController = TextEditingController();
  final streetNumberController = TextEditingController();

  // Function to save form data to Firestore
  Future<void> _submitForm() async {
    CollectionReference collRef = FirebaseFirestore.instance.collection('business');
    await collRef.add({
      'business_name': businessNameController.text,
      'manager_name': managerNameController.text,
      'phone_number': phoneNumberController.text,
      'city': cityController.text,
      'street': streetController.text,
      'street_number': streetNumberController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Business Sign In',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/backgroung1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(60.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: businessNameController,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: 'Business Name',
                      ),
                    ),
                    TextFormField(
                      controller: managerNameController,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: 'Manager Full Name',
                      ),
                    ),
                    TextFormField(
                      controller: phoneNumberController,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: 'Phone Number',
                      ),
                    ),
                    TextFormField(
                      controller: cityController,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: 'City',
                      ),
                    ),
                    TextFormField(
                      controller: streetController,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: 'Street',
                      ),
                    ),
                    TextFormField(
                      controller: streetNumberController,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: 'Building Number',
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: _submitForm, // Call the function to save form data
                      style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.transparent, // Button background color
                      side: BorderSide(color: Colors.white), // Border color
                      ),
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
