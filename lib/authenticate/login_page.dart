import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_dashboard/authenticate/screens/registration.dart';
import 'package:ecommerce_dashboard/home_page/home_page.dart';
import 'package:ecommerce_dashboard/widget/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/constants.dart';

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(22, 16, 75, 0.6),
      appBar: AppBar(
        // backgroundColor: const Color.fromRGBO(22, 16, 75, 0.9),
        backgroundColor: secondaryColor,
        title: const Text('Login'),
      ),
      body: Container(
        color: bgColor,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EmailPasswordFields(hint: 'email', controller: emailController),
            EmailPasswordFields(
              controller: passwordController,
              obscureText: isObscured,
              hint: 'password',
              icon: IconButton(
                icon: Icon(
                  !isObscured
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    isObscured = !isObscured;
                  });
                  log('isObscured: $isObscured');
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  _siginbutton(context);
                },
                child: const Text('Sign In'),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegistrationPage()));
                },
                child: const Text(
                  'Create new account',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(50)),
              child: IconButton(
                onPressed: () {
                  _googlesiginbutton(context);
                },
                icon: SvgPicture.asset(
                  'assets/icon_google.svg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class EmailPasswordFields extends StatelessWidget {
  EmailPasswordFields({
    super.key,
    this.icon,
    this.obscureText = false,
    required this.hint,
    required this.controller,
  });

  Widget? icon;
  bool obscureText;
  String hint;

  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: KpTextField(
        controller: controller,
        hint: hint,
        maxlines: 1,
        obscureText: obscureText,
        suffixWidget: icon,
      ),
    );
  }
}

Future<void> _siginbutton(BuildContext context) async {
  var navigator = Navigator.of(context);
  showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.amber,
          ),
        );
      });
  try {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    User user = userCredential.user!;
    navigator.pop();
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      log('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      log('Wrong password provided for that user.');
    }
    log('error: ${e.toString()}');
  }
}

Future<void> _googlesiginbutton(BuildContext context) async {
  var navigator = Navigator.of(context);
  try {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final UserCredential userCredential =
        await auth.signInWithCredential(credential);
    final User user = userCredential.user!;
    // Save the user's information to Firestore
    await _saveUserToFirestore(userCredential.user!);
    navigator.push(MaterialPageRoute(
      builder: (context) => HomePage(),
    ));
    log('Signed in user: ${user.displayName}');
  } catch (e) {
    log('Error occurred while signing in with Google: $e');
  }
}

// save users info using google sign in
Future<void> _saveUserToFirestore(User user) async {
  final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);

  // Create a map with the user's information
  final userData = {
    'userID': user.uid,
    'email': user.email,
    'firstName': user.displayName?.split(' ')[0] ?? '',
    'lastName': user.displayName?.split(' ')[1] ?? '',
    'photoUrl': user.photoURL ?? '',
    'phone number': user.phoneNumber,
    'email verified': user.emailVerified,
    'country': '',
  };

  await userRef.set(userData);
}
