import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  FirebaseServices(this._auth);
  final FirebaseAuth _auth;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // Stream<User?> get authStateChange => _auth.idTokenChanges();
  Stream<User?> get authStateChange => _auth.authStateChanges();

  Future<bool> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = userCredential.user!;
      return true;
    } on FirebaseAuthException catch (e) {
      // if (e.code == 'user-not-found') {
      //   log('No user found for that email.');
      // } else if (e.code == 'wrong-password') {
      //   log('Wrong password provided for that user.');
      // }
      // log('error: ${e.toString()}');
    }
    return false;
  }

  Future<void> createUserButton(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // displayFirebaseError(e);
    } catch (e) {
      // Handle other errors.
      // displayFirebaseError(e, context)
    }
  }

  Future<bool> googleSigninButton() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      final User user = userCredential.user!;
      log('user: ${user.displayName}');
      return true;
    } catch (err) {
      log('Error: $err');
      return false;
    }
  }

  Future<void> saveUserToFirestore(User user) async {
    final userRef =
        FirebaseFirestore.instance.collection('users').doc(user.uid);

    final userData = {
      'userID': user.uid,
      'email': user.email,
      'firstName': user.displayName?.split(' ')[0] ?? '',
      'lastName': user.displayName?.split(' ')[1] ?? '',
      'photoUrl': user.photoURL ?? '',
      'phone number': user.phoneNumber ?? '',
      'email verified': user.emailVerified,
      'country': ''
    };

    await userRef.set(userData);
  }

  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      return true;
    } on Exception catch (err) {
      log('error: $err');
      return false;
    }
  }

  void displayFirebaseError(FirebaseAuthException e, BuildContext context) {
    var snackBar = SnackBar(content: Text('Error: ${e.toString()}'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
