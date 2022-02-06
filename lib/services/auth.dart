import 'package:brew_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create user object based on a User
  Users? _userFromFirebaseUser(User? user) {
    return user != null ? Users(uid: user.uid) : null;
  }

  //Auth change user stream
  Stream<Users?> get user {
    return _auth.authStateChanges()
    // .map((User? user) => _userFromFirebaseUser(user));
    .map(_userFromFirebaseUser);
  }
  
  //Signing in anonymously
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch(error) {
      print(error.toString());
      return null;
    }
  }


  //Signing in with email and password


  //Register with email and password


  //Signing out
}