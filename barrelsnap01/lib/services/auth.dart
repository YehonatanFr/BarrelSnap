import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign in anon
  Future signInAnon () async {
    try{
     UserCredential authResult = await _auth.signInAnonymously();
     User? user = authResult.user;
     return user;
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign in email & password

  // sign with google

  // register with email & password

  // register with google

  // sign out
}