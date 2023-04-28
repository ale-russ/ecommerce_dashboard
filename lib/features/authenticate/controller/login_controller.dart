import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../home/controller/home_page_controller.dart';
import '../providers/auth_state_change_provider.dart';

final loginControllerProvider =
    StateNotifierProvider<LoginControllerNotifier, AsyncValue>((ref) {
  return LoginControllerNotifier(ref);
});

class LoginControllerNotifier extends StateNotifier<AsyncValue> {
  LoginControllerNotifier(this.ref) : super(const AsyncValue.loading());

  final Ref ref;

  Future<String> loginWithEmailPassword(
      String email, String password, BuildContext context) async {
    String response = '';

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      response = await ref
          .read(loginControllerProvider.notifier)
          .login(email, password);
      return response;
    });

    try {
      response = await ref
          .read(loginControllerProvider.notifier)
          .login(email, password);
      return response;
    } on Exception catch (err) {
      log('error: $err');
      response = err.toString();
    }
    return response;
  }

  Future<String> login(String email, String password) async {
    state = const AsyncValue.loading();
    String serverMessage = '';

    state = await AsyncValue.guard(() async {
      serverMessage =
          await ref.read(authProvider).signInWithEmailPassword(email, password);
    });

    return serverMessage;
  }

  Future<bool> signUp(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
        () => ref.read(authProvider).createUserButton(email, password));
    return true;
  }

  void signOut() {
    ref.read(authProvider).signOut();
    ref.watch(authProvider).googleSignIn.signOut();
    ref.invalidate(bottomNavigationProvider);
  }

  Future<void> googleSignIn() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() {
      return ref.read(authProvider).googleSigninButton();
    });
  }
}
