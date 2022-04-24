import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final GoogleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: GoogleAuth.accessToken,
      idToken: GoogleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    notifyListeners();

    void logout() async {
      await googleSignIn.disconnect();
      FirebaseAuth.instance.signOut();
    }

    
  }
}
