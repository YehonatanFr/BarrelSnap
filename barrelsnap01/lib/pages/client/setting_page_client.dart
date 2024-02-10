import 'package:flutter/material.dart';

/*

S E T T I N G P A G E

This is the SettingPage.
Currently it is just showing a vertical list of boxes.

This is where you should have a list of options for the user to control
depending on what your app does.

*/

class SettingPageClient extends StatelessWidget {
  const SettingPageClient({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background image or color
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/backgroung1.jpg'), 
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => Container(
                height: 100,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.grey[200], // Adjust opacity as needed
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
