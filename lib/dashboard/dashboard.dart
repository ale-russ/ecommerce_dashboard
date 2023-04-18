import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Dashboardpage extends ConsumerWidget {
  Dashboardpage({super.key});
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('dashboard page', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 16),
            Text('logged in as : ${user.email} ',
                style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
