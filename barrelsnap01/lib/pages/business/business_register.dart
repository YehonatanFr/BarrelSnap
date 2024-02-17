import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:BarrelSnap/pages/business/main_page_business.dart';
import 'package:BarrelSnap/services/auth.dart';

class BusinessSignIn extends StatefulWidget {
  @override
  _BusinessSignInState createState() => _BusinessSignInState();
}

class _BusinessSignInState extends State<BusinessSignIn> {
  final businessNameController = TextEditingController();
  final managerNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final birthdateController = TextEditingController();
  final cityController = TextEditingController();
  final streetController = TextEditingController();
  final streetNumberController = TextEditingController();
  final emailAdress = TextEditingController();
  final passwordBusiness = TextEditingController();

  final _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool checkValidPhoneNumber(String phoneNumber) {
    if (phoneNumber.length != 10) {
      print('Phone number must be 10 digits long');
      return false;
    }

    for (int i = 0; i < phoneNumber.length; i++) {
      int? digit = int.tryParse(phoneNumber[i]);
      if (digit == null) {
        print('Phone number must contain only numeric digits');
        return false;
      }
    }

    String prefix = phoneNumber.substring(0, 3);

    if (!isValidPrefix(prefix)) {
      print('Invalid prefix');
      return false;
    }

    return true;
  }

  bool isValidPrefix(String prefix) {
    switch (prefix) {
      case '050':
      case '052':
      case '053':
      case '054':
      case '055':
      case '057':
      case '058':
        return true;
      default:
        return false;
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
      final DateTime eighteenYearsAgo = DateTime.now().subtract(const Duration(days: 18 * 365));
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

  InputDecoration _buildInputDecoration(String labelText) {
    return InputDecoration(
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      fillColor: Colors.grey.shade900,
      filled: true,
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.white),
      hintText: labelText,
      hintStyle: TextStyle(color: Colors.grey[500]),
    );
  }

  Future<void> _saveUserDataToFirestore() async {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('business');

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await usersCollection.doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'birthdate': birthdateController.text,
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Business Sign In',
      home: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text(
            'Business Register',
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
                          controller: businessNameController,
                          decoration: _buildInputDecoration('Business Name'),
                          style: const TextStyle(color: Colors.white),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter Business name';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: managerNameController,
                          decoration: _buildInputDecoration('Manager Full Name'),
                          style: const TextStyle(color: Colors.white),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter Business\'s Manager Full name';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: phoneNumberController,
                          decoration: _buildInputDecoration('Phone Number'),
                          style: const TextStyle(color: Colors.white),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter Phone Number';
                            } else if (!checkValidPhoneNumber(phoneNumberController.text)) {
                              return 'Invalid Phone Number';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          readOnly: true,
                          controller: birthdateController,
                          onTap: _selectDate,
                          decoration: _buildInputDecoration('Date of Birth'),
                          style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter Age over 18';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: cityController,
                          decoration: _buildInputDecoration('City'),
                          style: const TextStyle(color: Colors.white),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter City';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: streetController,
                          decoration: _buildInputDecoration('Street'),
                          style: const TextStyle(color: Colors.white),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter Street';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: streetNumberController,
                          decoration: _buildInputDecoration('Building Number'),
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter Building Number';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          onChanged: (value) {
                            setState(() => email = value);
                          },
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter an email';
                            }
                            return null;
                          },
                          decoration: _buildInputDecoration('E-Mail'),
                          style: const TextStyle(color: Colors.white),
                          obscureText: false,
                        ),
                        TextFormField(
                          onChanged: (value) {
                            setState(() => password = value);
                          },
                          style: const TextStyle(color: Colors.white),
                          obscureText: true,
                          decoration: _buildInputDecoration('Password'),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return 'Enter a password 6+ chars long';
                            }
                            return null;
                          },
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            dynamic result = await _auth
                                .registerWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() => error = 'Please supply a valid email');
                            } else {
                              await _saveUserDataToFirestore();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MainPageBusiness(),
                                ),
                              );
                            }
                          },
                          child: const Text('Submit'),
                        ),
                        const SizedBox(height: 12.0),
                        Text(
                          error,
                          style: const TextStyle(color: Colors.red, fontSize: 14.0),
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
