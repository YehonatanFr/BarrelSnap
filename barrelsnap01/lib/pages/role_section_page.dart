import 'package:flutter/material.dart';
import '../pages/business/business_register.dart';
import '../pages/client/client_register.dart';


class RoleSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register Options',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent, // Make app bar transparent
        elevation: 0, // Remove app bar shadow
      ),
      extendBodyBehindAppBar: true, // Extend background behind app bar
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/backgroung1.jpg'), // Add your background photo asset here
            fit: BoxFit.cover, // Cover entire screen
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Navigate to client details screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ClientSingIn()),
                  );
                },
                style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.transparent, // Text color
                  side: BorderSide(color: Colors.white), // Border color
                ),
                child: const Text('Register as Client'),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  // Navigate to manager details screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BusinessSignIn()),
                  );
                },
                style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.transparent, // Text color
                  side: BorderSide(color: Colors.white), // Border color
                ),
                child: const Text('Register as Business'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}