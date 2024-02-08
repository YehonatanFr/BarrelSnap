import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:startertemplate/pages/client/main_page_client.dart'; 
import '../client/profile_page_client.dart';

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
  
  String? userId; // Variable to store the document ID

  // Method to calculate age from date of birth
  int calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    final difference = now.difference(birthDate);
    return (difference.inDays / 365).floor();
  }

  // Function to show date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != DateTime.now()) {
      final DateTime eighteenYearsAgo = DateTime.now().subtract(Duration(days: 18 * 365));
      if (picked.isBefore(eighteenYearsAgo)) {
        setState(() {
          birthdateController.text = DateFormat('yyyy-MM-dd').format(picked);
        });
      } else {
        // Show an error message indicating the user is under 18 years old
        showDialog(
          context: context,
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
        body: Stack(
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
                        onTap: () {
                          _selectDate(context);
                        },
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
                      ElevatedButton(
                        onPressed: () async {
                          CollectionReference collRef = FirebaseFirestore.instance.collection('customer');
                          DocumentReference docRef = await collRef.add({
                            'fname': fnameController.text,
                            'lname': lnameController.text,
                            'Date of birth': birthdateController.text,
                            'Phone number': phonenumberController.text,
                            'City': cityController.text,
                            'Street': streetController.text,
                            'Street number': streetnumberController.text,
                          });
                          // Get the document ID
                          userId = docRef.id;
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile created successfully')));

                          // Navigate to MainPage after submitting the form
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainPageClient(),
                            ),
                          );

                          // Navigate to ProfilePage with userId
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfilePageClient(userId: userId),
                            ),
                          );
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
