import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../business/business_register.dart';

class ProfilePageBusiness extends StatefulWidget {
  final String? userId;

  const ProfilePageBusiness({Key? key, this.userId}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePageBusiness> {
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController phonenumberController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController streetnumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: fnameController,
                decoration: InputDecoration(labelText: 'First Name'),
              ),
              TextFormField(
                controller: lnameController,
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
              TextFormField(
                readOnly: true,
                controller: birthdateController,
                decoration: InputDecoration(labelText: 'Date of Birth'),
                onTap: () => _selectDate(context),
              ),
              TextFormField(
                controller: phonenumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              TextFormField(
                controller: cityController,
                decoration: InputDecoration(labelText: 'City'),
              ),
              TextFormField(
                controller: streetController,
                decoration: InputDecoration(labelText: 'Street'),
              ),
              TextFormField(
                controller: streetnumberController,
                decoration: InputDecoration(labelText: 'Building Number'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _updateProfile();
                },
                child: Text('Update Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        birthdateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _populateTextControllers() async {
    try {
      final CollectionReference collRef =
          FirebaseFirestore.instance.collection('business');
      User? user = FirebaseAuth.instance.currentUser;
      final docSnapshot = await collRef.doc(user!.uid).get();

      if (docSnapshot.exists) {
        var userData = docSnapshot.data() as Map<String, dynamic>;
        setState(() {
          fnameController.text = userData['fname'];
          lnameController.text = userData['lname'];
          birthdateController.text = userData['birthdate'];
          phonenumberController.text = userData['phonenumber'];
          cityController.text = userData['city'];
          streetController.text = userData['street'];
          streetnumberController.text = userData['streetnumber'];
        });
      }
    } catch (e) {
      print('Failed to populate text controllers: $e');
    }
  }

  Future<void> _updateProfile() async {
    try {
      final CollectionReference collRef =
          FirebaseFirestore.instance.collection('business');
      User? user = FirebaseAuth.instance.currentUser;
      final docSnapshot = await collRef.doc(user!.uid).get();

      if (docSnapshot.exists) {
        await collRef.doc(user!.uid).update({
          'fname': fnameController.text,
          'lname': lnameController.text,
          'birthdate': birthdateController.text,
          'phonenumber': phonenumberController.text,
          'city': cityController.text,
          'street': streetController.text,
          'streetnumber': streetnumberController.text,
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profile updated successfully')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Profile does not exist')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to update profile')));
      // }
    }
  }
}