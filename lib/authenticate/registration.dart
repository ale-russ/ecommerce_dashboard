import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dashboard_page.dart';
import '../widget/textfield.dart';
import 'login_page.dart';

class RegistrationPage extends ConsumerWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: Color.fromRGBO(22, 16, 75, 0.6),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 64),
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
                  _createbutton(context, emailController.text.trim(),
                      passwordController.text.trim());
                },
                child: Text('create new'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final authProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

Future<void> _createbutton(
    BuildContext context, String email, String password) async {
  try {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DashboardPage()));
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('please enter strong password');
    } else if (e.code == 'email-already-in-use') {
      print('email-already-in-use');
    } else if (e.code == 'invalid-email') {
      print('The email address is invalid.');
    } else {
      // Handle other errors.
    }
  } catch (e) {
    // Handle other errors.
  }
}
