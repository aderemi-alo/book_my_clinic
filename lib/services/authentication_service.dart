import 'package:firebase_auth/firebase_auth.dart';
import '../models/result.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? getCurrentUser() => _firebaseAuth.currentUser;

  Future<void> signOut() => _firebaseAuth.signOut();

  Future<Result<void>> login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return Result.success(null);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.toString());
      return Result.error(_handleFirebaseAuthException(e));
    } catch (e) {
      print("Random error");
      return Result.error(e.toString());
    }
  }

  Future<Result<void>> signUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return Result.success(null);
    } on FirebaseAuthException catch (e) {
      return Result.error(_handleFirebaseAuthException(e));
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  Future<Result<void>> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return Result.success(null);
    } on FirebaseAuthException catch (e) {
      return Result.error(_handleFirebaseAuthException(e));
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  String _handleFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      case 'email-already-in-use':
        return 'The email address is already in use by another account.';
      case 'invalid-email':
        return 'Email address is invalid.';
      case 'weak-password':
        return 'Password should be at least 6 characters.';
      case 'user-disabled':
        return 'The user account has been disabled.';

      default:
        return e.message ?? 'An error occurred. Please try again later.';
    }
  }
}
