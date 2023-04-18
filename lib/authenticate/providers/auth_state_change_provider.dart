import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/firebase_services.dart';

final authProvider = Provider<FirebaseServices>(
  (ref) {
    return FirebaseServices(FirebaseAuth.instance);
  },
);

final authStateProvider = StreamProvider.autoDispose<User?>((ref) {
  return ref.read(authProvider).authStateChange;
});
