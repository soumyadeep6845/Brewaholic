import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  //Signing in anonymously
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return user;
    } catch(error) {
      print(error.toString());
      return null;
    }
  }


  //Signing in with email and password


  //Register with email and password


  //Signing out
}