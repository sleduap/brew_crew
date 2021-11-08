import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create user object based on Firebase User
  Users? _userFromFirebaseUser(User? user) {
    return user != null ? Users(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<Users?> get user1 {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // Sign up Anon
  Future signAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;

      return _userFromFirebaseUser(user);
    } catch (error) {
      // print("Error in Signing up ${error.toString()}");
      // print(null);
      return null;
    }
  }

  // Sign up using Email and password
  Future signinWithEandP(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (error) {
      return null;
    }
  }

  // Register using Email And password
  Future registrWithEandP(String email, String password, String sugar,
      String name, int strength) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      Database(uid: user!.uid).updateData(sugar, name, strength);
      return _userFromFirebaseUser(user);
    } catch (error) {
      return null;
    }
  }

  //Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
