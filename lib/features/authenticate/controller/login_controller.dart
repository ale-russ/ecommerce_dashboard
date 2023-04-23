import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/load_status.dart';
import '../providers/auth_state_change_provider.dart';

class LoginControllerNotifier extends StateNotifier<LoadStatus> {
  LoginControllerNotifier(this.ref) : super(LoadStatus.empty);

  final Ref ref;

  Future<bool> login(String email, String password) async {
    state = LoadStatus.loading;

    try {
      await ref.read(authProvider).signInWithEmailPassword(email, password);
      return true;
      // state = LoadStatus.loaded;
    } catch (e) {
      state = LoadStatus.error;
    }
    return false;
  }

  Future<bool> signUp(String email, String password) async {
    state = LoadStatus.loading;

    try {
      await ref.read(authProvider).createUserButton(email, password);
      return true;
    } catch (e) {
      state = LoadStatus.error;
    }
    return false;
  }

  void signOut() async {
    await ref.read(authProvider).signOut().then((value) {
      ref.read(loggedIn.notifier).setLogin(false);
    });
  }

  void googleSignIn() async {
    await ref.read(authProvider).googleSigninButton().then((value) {
      ref.read(loggedIn.notifier).setLogin(true);
    });
  }
}

final loginControllerProvider =
    StateNotifierProvider<LoginControllerNotifier, LoadStatus>((ref) {
  return LoginControllerNotifier(ref);
});