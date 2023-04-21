import 'dart:developer';

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

final loggedIn =
    StateNotifierProvider<LoginNotifier, bool>((ref) => LoginNotifier(false));

class LoginNotifier extends StateNotifier<bool> {
  LoginNotifier(bool isLoggedIn) : super(isLoggedIn);
  @override
  build() {
    log('State: $state');
    return state;
  }

  void setLogin(bool isLoggedIn) {
    state = isLoggedIn;
  }
}
