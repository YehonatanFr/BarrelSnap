import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:startertemplate/pages/client/main_page_client.dart';
import 'package:startertemplate/services/auth.dart';

class ClientSingIn extends StatefulWidget {
  @override
  _ClientSingInState createState() => _ClientSingInState();
}

class _ClientSingInState extends State<ClientSingIn> {
  final lnameController = TextEditingController();
  final fnameController = TextEditingController();
  final birthdateController = TextEditingController();
  final phonenumberController = TextEditingController();
  final cityController = TextEditingController();
  final streetController = TextEditingController();
  final streetnumberController = TextEditingController();
  final emailAdress = TextEditingController();
  final passwordClient = TextEditingController();

  final _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  final scaffoldKey = GlobalKey<ScaffoldState>();

  int calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    final difference = now.difference(birthDate);
    return (difference.inDays / 365).floor();
  }

  Future<void> _saveUserDataToFirestore() async {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    // Check if the user is authenticated
    if (user != null) {
      // Add user data along with the user ID
      await usersCollection.doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'fname': fnameController.text,
        'lname': lnameController.text,
        'birthdate': birthdateController.text,
        'phonenumber': phonenumberController.text,
        'city': cityController.text,
        'street': streetController.text,
        'streetnumber': streetnumberController.text,
      });
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: scaffoldKey.currentContext!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != DateTime.now()) {
      final DateTime eighteenYearsAgo =
          DateTime.now().subtract(Duration(days: 18 * 365));
      if (picked.isBefore(eighteenYearsAgo)) {
        setState(() {
          birthdateController.text = DateFormat('yyyy-MM-dd').format(picked);
        });
      } else {
        showDialog(
          context: scaffoldKey.currentContext!,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text('You must be over 18 years old.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wine Barrel Form',
      home: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text(
            'Sign In',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        extendBodyBehindAppBar: true,
        body: Form(
          key: _formKey,
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
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
                          controller: fnameController,
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(color: Colors.white),
                            labelText: 'Private Name',
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                        TextFormField(
                          controller: lnameController,
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(color: Colors.white),
                            labelText: 'Family Name',
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                        TextFormField(
                          readOnly: true,
                          controller: birthdateController,
                          onTap: _selectDate,
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(color: Colors.white),
                            labelText: 'Date of Birth',
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                        TextFormField(
                          controller: phonenumberController,
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(color: Colors.white),
                            labelText: 'Phone Number',
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                        TextFormField(
                          controller: cityController,
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(color: Colors.white),
                            labelText: 'City',
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                        TextFormField(
                          controller: streetController,
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(color: Colors.white),
                            labelText: 'Street',
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                        TextFormField(
                          controller: streetnumberController,
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(color: Colors.white),
                            labelText: 'Building Number',
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
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
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return 'Enter a password 6+ chars long';
                            }
                            return null; // Return null if the input is valid
                          },
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                      email, password);

                              if (result == null) {
                                setState(() =>
                                    error = 'Please supply a valid email');
                              } else {
                                await _saveUserDataToFirestore();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MainPageClient(),
                                  ),
                                );
                              }
                            }
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
        ),
      ),
    );
  }
}