import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'authenticate/screens/auth_page.dart';
import 'authenticate/screens/login_page.dart';
import 'constants/constants.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    // ignore: empty_catches
  } catch (e) {}

  runApp(
    ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  App({
    super.key,
  });

  final GoRouter router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const AuthPage();
      },
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
      routerConfig: router,
      // home: const AuthPage(),
    );
  }
}
