import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../authenticate/controller/login_controller.dart';
import '../constants/constants.dart';

class HomePage extends ConsumerWidget {
  HomePage({Key? key}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  ref.read(loginControllerProvider.notifier).signOut();
                },
                child: const Text('Logout')),
          )
        ],
      ),
    );
  }
}
