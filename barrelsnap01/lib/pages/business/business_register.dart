import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:startertemplate/pages/business/main_page_business.dart';
import 'package:startertemplate/pages/client/main_page_client.dart';
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
      labelStyle: TextStyle(color: Colors.white),
      hintText: labelText,
      hintStyle: TextStyle(color: Colors.grey[500]),
    );
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
            'Business Sign In',
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
                          style: TextStyle(color: Colors.white),
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
                          style: TextStyle(color: Colors.white),
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
                          style: TextStyle(color: Colors.white),
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
                          controller: cityController,
                          decoration: _buildInputDecoration('City'),
                          style: TextStyle(color: Colors.white),
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
                          style: TextStyle(color: Colors.white),
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
                            return null;
                          },
                          decoration: _buildInputDecoration('E-Mail'),
                          style: TextStyle(color: Colors.white),
                          obscureText: false,
                        ),
                        TextFormField(
                          onChanged: (value) {
                            setState(() => password = value);
                          },
                          style: TextStyle(color: Colors.white),
                          obscureText: true,
                          decoration: _buildInputDecoration('Password'),
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return 'Enter a password 6+ chars long';
                            }
                            return null;
                          },
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() => error = 'Please supply a valid email');
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MainPageBusiness(),
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
