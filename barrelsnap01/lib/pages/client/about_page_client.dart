import 'package:flutter/material.dart';

/*

A B O U T P A G E

This is the AboutPage. This is usually a static page that displays lots of text
describing what your app/business does.

This is also a great place to give the user a link or email that they can use 
to give any feedback about the app.

*/

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        title: Text(
          'A B O U T',
          style: TextStyle(color: Colors.grey[800]),
        ),
      ),
      body: Stack(
        children: [
          // Background image
          Image.asset(
            'lib/images/backgroung1.jpg', // Adjust the path to your background image
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.5), // Adjust opacity as needed
            width: double.infinity,
            height: double.infinity,
          ),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Text(
                  'About',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'This app was designed to provide a comprehensive platform for both wineries and wine enthusiasts.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Features:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '- Customers and winery owners can track the wine production process from grape stage to bottle purchase.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '- Users can purchase wine bottles directly through the app.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '- Information about wine festivals and events at wineries is available.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Benefits:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '- Wineries can showcase their products and events to a wider audience, increasing sales and visibility.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '- Customers have easy access to information about different wines and can make purchases conveniently.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '- The app promotes the wine industry and facilitates connections between producers and consumers.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}