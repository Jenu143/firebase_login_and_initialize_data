import 'package:firebase_auth/firebase_auth.dart';

class Authantication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //? Sing up method
  Future<String?> singUp({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //? Log in method
  Future<String?> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //? Log in method
  Future<String?> resetPassword({
    required String email,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(
        email: email,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //? log out method
  Future<void> logOut() async {
    await _auth.signOut();

    print("Sing Out");
  }
}
