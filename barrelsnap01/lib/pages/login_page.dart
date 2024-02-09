import 'package:flutter/material.dart';
import '/components/my_login_button.dart';
import '/components/my_square_tile.dart';
import '/components/my_textfield.dart';
import '/pages/role_section_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/*

L O G I N P A G E

This is the LoginPage, the first page the user will see based off what was configured in the main.dart file.
This is a minimal aesthetic design, but feel free to decorate it to fit your app.

When considering loggin users into your app, you must consider AUTHENTICATION:

- email sign in
- google sign in

There are many authentication services including firebase. This is highly dependent on your needs.

Once the user is authenticated, they are directed to the homepage.

*/

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

//text editing controllers
final usernameController = TextEditingController();
final passwordController = TextEditingController();

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();
  // sign user in method
  // void signUserIn() async {
  //   await FirebaseAuth.instance.signInWithEmailAndPassword(
  //     email: usernameController.text,
  //     password: passwordController.text,
  //   );
  //   FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //     if (user == null) {
  //       print('User is currently signed out!');
  //     } else {
  //       print('User is signed in!');
  //       // once user is authenticated, direct them to the main page
  //       Navigator.pop(context);
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const MainPage(),
  //         ),
  //       );
  //     }
  //   });
  // }
  void signUserIn() {
    // Once user is authenticated, direct them to the role selection screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RoleSelectionScreen(),
      ),
    );
  }
  // Function to sign in with Google
  void signUserInGoogle() async {
    try {
      // Initialize GoogleSignIn
      GoogleSignIn googleSignIn = GoogleSignIn();

      // Attempt to sign in with Google
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      // Check if sign-in was successful
      if (googleSignInAccount != null) {
        // Get authentication tokens from GoogleSignInAccount
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        // Create GoogleAuthProviderCredential using the authentication tokens
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        // Sign in with Firebase using the credential
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        // Check if sign-in with Firebase was successful
        if (userCredential.user != null) {
          // Navigate to the next screen or perform any other action
          navigateToMainPage();
        } else {
          // Handle sign-in failure
          print('Sign-in with Google failed.');
        }
      } else {
        // Handle sign-in cancellation
        print('Sign-in with Google cancelled.');
      }
    } catch (error) {
      // Handle sign-in error
      print('Sign-in with Google error: $error');
    }
  }

  // Function to navigate to the main page
  void navigateToMainPage() {
    // Here, you can navigate to the main page using Navigator
    print('Navigating to the main page...');
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RoleSelectionScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/backgroung1.jpg'), // Add your background photo asset here
                fit: BoxFit.cover, // Cover entire screen
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),

                  // logo
                  const Icon(
                    Icons.lock,
                    size: 100,
                    color: Color.fromARGB(255, 198, 193, 193),
                  ),

                  const SizedBox(
                    height: 50,
                  ),
                  //welcome back youve been missed
                  Text(
                    'Welcome back you\'ve been missed!',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  //username textfiled
                  MyTextField(
                      controller: usernameController,
                      hintText: 'Username',
                      obscureText: false),

                  // password textfiled
                  MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true),

                  //forgut password
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(color: const Color.fromARGB(255, 255, 253, 253)),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),
                  //sign in button

                  MyButton(onTap: signUserIn),

                  const SizedBox(
                    height: 50,
                  ),
                  //or continue with
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: const Color.fromARGB(255, 255, 254, 254),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Text(
                            'Or continue with',
                            style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50),

                  // google sign in buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // google button
                      SquareTile(
                        imagePath: 'lib/images/google.png',
                        onTap: signUserInGoogle,
                      ),
                    SizedBox(width: 25),
                    
                    // Text button for registration
                    TextButton(
                      onPressed: () {
                        // Navigate to RoleSelectionScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RoleSelectionScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Not a member? \n Register now',
                        style: TextStyle(color: const Color.fromARGB(255, 254, 255, 255), 
                        fontWeight: FontWeight.bold),
                      ),
                    ),

                      // SizedBox(width: 25),

                      // apple button
                      //SquareTile(imagePath: 'lib/images/apple.png')
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
