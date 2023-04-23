import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/user.dart';

class Usersrepository {
  Stream<List<Users>> listusers(String email) {
    try {
      final data = FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .snapshots()
          .map(
            (snapshot) =>
                snapshot.docs.map((doc) => Users.fromMap(doc.data())).toList(),
          );
      print('list of users ${email}');
      return data;
    } catch (e) {
      throw ('Something went wrong here....');
    }
  }
}

final UsersRepositoryProvider = Provider<Usersrepository>((ref) {
  return Usersrepository();
});
