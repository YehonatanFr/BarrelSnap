import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:startertemplate/pages/business/main_page_business.dart';
import 'package:startertemplate/services/auth.dart';

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
  final emailAdress = TextEditingController();
  final passwordBusiness = TextEditingController();

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _saveUserDataToFirestore() async {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('business');

    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    // Check if the user is authenticated
    if (user != null) {
      // Add user data along with the user ID
      await usersCollection.doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'business_name': businessNameController.text,
        'manager_name': managerNameController.text,
        'phone_number': phoneNumberController.text,
        'city': cityController.text,
        'street': streetController.text,
        'street_number': streetNumberController.text,
      });
    }
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
                    TextFormField(
                      // controller: emailAdress,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: 'Email Adress',
                      ),
                    ),
                    TextFormField(
                        // controller: password,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: 'Password',
                        ),
                        obscureText: true),
                    SizedBox(height: 20.0),
                    TextFormField(
                      onChanged: (value) {
                        setState(() => email = value);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter an email';
                        }
                        return null; // Return null if the input is valid
                      },
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: 'E-Mail',
                      ),
                      style: TextStyle(color: Colors.white),
                      obscureText: false,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        setState(() => password = value);
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: 'Password',
                      ),
                      style: TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'Enter a password 6+ chars long';
                        }
                        return null; // Return null if the input is valid
                      },
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // if (_formKey.currentState?.validate() ?? false) {
                        dynamic result = await _auth
                            .registerWithEmailAndPassword(email, password);

                        if (result == null) {
                          setState(() => error = 'Please supply a valid email');
                        } else {
                          await _saveUserDataToFirestore();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainPageBusiness(),
                            ),
                          );
                        }
                        //}
                      },
                      child: const Text('Submit'),
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
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