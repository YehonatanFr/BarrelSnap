import 'package:firebase_auth/firebase_auth.dart';
import 'package:startertemplate/models/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
 
  // create user obj based on  user fire base
  UserUid? _userFromFirebase (User? user){
    return user != null ? UserUid(uid: user.uid) : null;
  }

// auth change user stream
Stream<UserUid?> get user {
  return _auth.authStateChanges()
  .map((User? user) => _userFromFirebase(user));
}


  // sign in anon
  Future signInAnon () async {
    try{
     UserCredential authResult = await _auth.signInAnonymously();
     User? user = authResult.user;
     return _userFromFirebase(user);
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