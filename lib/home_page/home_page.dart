import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        leading: Container(
          color: Colors.green,
          width: 80,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Dashboard',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                '${user.email}',
                style: const TextStyle(fontSize: 12),
              ),
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'LOGGED IN AS: ${user.email}',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 40),
          Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(
                onPressed: () async {
                  FirebaseAuth.instance.signOut();
                },
                child: const Text('Logout')),
          )
        ],
      ),
    );
  }
}
