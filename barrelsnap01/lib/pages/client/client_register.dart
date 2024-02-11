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


  int calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    final difference = now.difference(birthDate);
    return (difference.inDays / 365).floor();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: scaffoldKey.currentContext!,
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
      labelStyle: TextStyle(color: Colors.white),
      hintText: labelText,
      hintStyle: TextStyle(color: Colors.grey[500]),
    );
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
                          decoration: _buildInputDecoration('Private Name'),
                          style: TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter Private name';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: lnameController,
                          decoration: _buildInputDecoration('Family Name'),
                          style: TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter Family name';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          readOnly: true,
                          controller: birthdateController,
                          onTap: _selectDate,
                          decoration: _buildInputDecoration('Date of Birth'),
                          style: TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter Age over 18';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: phonenumberController,
                          decoration: _buildInputDecoration('Phone Number'),
                          style: TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter Phone Number';
                            } else if (!checkValidPhoneNumber(phonenumberController.text)) {
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
                          controller: streetnumberController,
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
                          obscureText: false,
                        ),
                        TextFormField(
                          onChanged: (value) {
                            setState(() => password = value);
                          },
                          obscureText: true,
                          decoration: _buildInputDecoration('Password'),
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
                              dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() => error = 'Please supply a valid email');
                              } else {
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
