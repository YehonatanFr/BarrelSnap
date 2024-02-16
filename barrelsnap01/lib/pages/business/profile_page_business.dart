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
  final businessNameController = TextEditingController();
  final managerNameController = TextEditingController();
  final birthdateController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final cityController = TextEditingController();
  final streetController = TextEditingController();
  final streetNumberController = TextEditingController();
  final emailAdress = TextEditingController();
  final passwordBusiness = TextEditingController();

  @override
  void initState() {
    super.initState();
    _populateTextControllers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: businessNameController,
                decoration: InputDecoration(labelText: 'Business Name'),
                
              ),
              TextFormField(
                controller: managerNameController,
                decoration: InputDecoration(labelText: 'Manager Full Name'),
              ),
              TextFormField(
                readOnly: true,
                controller: birthdateController,
                decoration: InputDecoration(labelText: 'Date of Birth'),
                onTap: () => _selectDate(context),
              ),
              TextFormField(
                controller: phoneNumberController,
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
                controller: streetNumberController,
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
        businessNameController.text = userData['business_name'] ?? '';
        managerNameController.text = userData['manager_name'] ?? '';
        birthdateController.text = userData['birthdate'] ?? '';
        phoneNumberController.text = userData['phone_number'] ?? '';
        cityController.text = userData['city'] ?? '';
        streetController.text = userData['street'] ?? '';
        streetNumberController.text = userData['street_number'] ?? '';
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
      
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User not logged in')));
        return;
      }

      final docSnapshot = await collRef.doc(user.uid).get();

      if (!docSnapshot.exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile does not exist')));
        return;
      }

      // Perform the update
      await collRef.doc(user.uid).update({
        'business_name': businessNameController.text,
        'manager_name': managerNameController.text,
        'birthdate': birthdateController.text,
        'phone_number': phoneNumberController.text,
        'city': cityController.text,
        'street': streetController.text,
        'street_number': streetNumberController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')));
    } catch (e) {
      print('Error updating profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: $e')));
    }
  }

}