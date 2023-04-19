import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_dashboard/models/orders.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardRepository {
//all orders
  Stream<List<orders>> orderlist() {
    try {
      final data = FirebaseFirestore.instance
          .collection('orders')
          .snapshots()
          .map(
            (snapshot) =>
                snapshot.docs.map((doc) => orders.fromMap(doc.data())).toList(),
          );
      return data;
    } catch (e) {
      throw ('Something went wrong here....');
    }
  }

  // list of packing
  Stream<List<orders>> packinglist() {
    try {
      final data = FirebaseFirestore.instance
          .collection('orders')
          .where('status', isEqualTo: 'packing')
          .snapshots()
          .map(
            (snapshot) =>
                snapshot.docs.map((doc) => orders.fromMap(doc.data())).toList(),
          );
      return data;
    } catch (e) {
      throw ('Something went wrong here....');
    }
  }

  // list of delivered
  Stream<List<orders>> deliveredlist() {
    try {
      final data = FirebaseFirestore.instance
          .collection('orders')
          .where('status', isEqualTo: 'delivered')
          .snapshots()
          .map(
            (snapshot) =>
                snapshot.docs.map((doc) => orders.fromMap(doc.data())).toList(),
          );
      return data;
    } catch (e) {
      throw ('Something went wrong here....');
    }
  }

  // list of completed
  Stream<List<orders>> completedlist() {
    try {
      final data = FirebaseFirestore.instance
          .collection('orders')
          .where('status', isEqualTo: 'completed')
          .snapshots()
          .map(
            (snapshot) =>
                snapshot.docs.map((doc) => orders.fromMap(doc.data())).toList(),
          );
      return data;
    } catch (e) {
      throw ('Something went wrong here....');
    }
  }
}

final DashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepository();
});
