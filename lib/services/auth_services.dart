// ignore_for_file: prefer_final_fields, unused_field, avoid_print, unused_local_variable, unused_import, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/homepage.dart';

class AuthService {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  void showSnackBar(BuildContext context, String error) {
    var snackBar = SnackBar(
      content: DefaultTextStyle(
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        child: Text(
          error,
          style: GoogleFonts.lobster(),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 134, 4, 48),
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future signUp(String email, String password) async {
    await storeToken();
    await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future loginUser(String email, String password) async {
    await storeToken();
    await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future googleLogin(BuildContext context) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        firebase_auth.OAuthCredential googleAuthCredential =
            firebase_auth.GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
        try {
          firebase_auth.UserCredential userCredential =
              await firebaseAuth.signInWithCredential(googleAuthCredential);
          await storeToken();
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context) {
              return HomePage();
            },
          ), (route) => false);
          showSnackBar(context, "Logged In Successfully");
        } catch (error) {
          showSnackBar(context, error.toString());
        }
      } else {
        showSnackBar(context, "Unwanted Errors Accoured");
      }
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

  Future userSignOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', 'Logged Out');
    await _googleSignIn.signOut();
    await firebaseAuth.signOut();
  }

  Future storeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', 'Logged In');
  }

  Future checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
