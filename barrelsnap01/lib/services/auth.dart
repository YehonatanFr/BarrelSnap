import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
 
  // create user obj based on  user fire base
  Stream<User?> get user {
    return _auth.authStateChanges().map((User? user) => user);
  }


  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential authResult = await _auth.signInAnonymously();
      User? user = authResult.user;
      print(user?.uid);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


  // sign out
  Future signOut() async{
    try{
      print('logout succes');
      return await _auth.signOut();
      
    } catch (e){
      print(e.toString());
      return null;
    }
  }

  // forgot password

  Future forgotPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      } on FirebaseAuthException catch (err) {
      throw Exception(err.message.toString());
      } catch (err) {
      throw Exception(err.toString());
    }
  }
}