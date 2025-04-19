import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
class Auth{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signIn({
    required String email,
    required String password
  })async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<void> signUp({
    required String email,
    required String password
  })async{
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password
    );
  }

  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await _firebaseAuth.signOut();
  }
  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
  }
}