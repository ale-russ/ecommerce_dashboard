import 'dart:developer';

import 'package:ecommerce_dashboard/routes/router.dart';
import 'package:ecommerce_dashboard/routes/router_provider.dart';
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
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends ConsumerWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    log('router: $router');

    return MaterialApp.router(
      routeInformationParser: AppRoutes().router.routeInformationParser,
      routeInformationProvider: AppRoutes().router.routeInformationProvider,
      routerDelegate: AppRoutes().router.routerDelegate,
      // routerConfig: router,
      // routerConfig: AppRoutes().router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
    );
  }
}
