import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/user.dart';
import '../services/account_repo.dart';

class Accountcontrollers {
  Accountcontrollers({required this.ref});
  final Ref ref;

  Stream<List<Users>> userlist() {
    try {
      final users = FirebaseAuth.instance.currentUser!;
      final email = users.email;
      return ref.read(UsersRepositoryProvider).listusers(email.toString());
    } catch (e) {
      throw ('Something went wrong here....');
    }
  }
}

final AccountcontrollerProvider = Provider<Accountcontrollers>((ref) {
  return Accountcontrollers(ref: ref);
});
final UserProvider = StreamProvider<List<Users>>((ref) {
  return ref.read(AccountcontrollerProvider).userlist();
});

// <List<Users>>((ref) async {
//   return ref.read(AccountcontrollerProvider).userlist();
// });
