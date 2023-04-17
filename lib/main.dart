import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'authenticate/login_page.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    // ignore: empty_catches
  } catch (e) {}

  runApp(
    const ProviderScope(
      child: MaterialApp(home: LoginPage(), debugShowCheckedModeBanner: false),
    ),
  );
}
