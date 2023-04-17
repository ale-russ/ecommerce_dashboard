import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_dashboard/authenticate/registration.dart';
import 'package:ecommerce_dashboard/dashboard_page.dart';
import 'package:ecommerce_dashboard/widget/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_svg/svg.dart';

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(22, 16, 75, 0.6),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(22, 16, 75, 0.9),
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            KpTextField(
              controller: emailController,
              hint: 'email',
            ),
            const SizedBox(height: 16),
            KpTextField(
              controller: passwordController,
              hint: 'password',
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  _siginbutton(context);
                },
                child: Text('Sign In'),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegistrationPage()));
                },
                child: Text(
                  'create new account',
                  style: TextStyle(color: Colors.amber),
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(color: Colors.white),
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

Future<void> _siginbutton(BuildContext context) async {
  try {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    User user = userCredential.user!;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DashboardPage()));
    print('Signed in user: ${user.email}');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}

Future<void> _googlesiginbutton(BuildContext context) async {
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
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DashboardPage()));
    print('Signed in user: ${user.displayName}');
  } catch (e) {
    print('Error occurred while signing in with Google: $e');
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
