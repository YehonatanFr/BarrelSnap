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
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/backgroung1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ClientSingIn()),
                  );
                },
                style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.transparent,
                  side: const BorderSide(color: Colors.white),
                ),
                child: const Text('Register as Client'),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BusinessSignIn()),
                  );
                },
                style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.transparent,
                  side: const BorderSide(color: Colors.white),
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