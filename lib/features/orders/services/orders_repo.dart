import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_dashboard/features/models/orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Ordersrepository {
  Stream<List<Orders>> orderlist() {
    try {
      final data = FirebaseFirestore.instance
          .collection('orders')
          .snapshots()
          .map(
            (snapshot) =>
                snapshot.docs.map((doc) => Orders.fromMap(doc.data())).toList(),
          );
      return data;
    } catch (e) {
      throw ('Something went wrong here....');
    }
  }
}

final ordersRepositoryProvider = Provider<Ordersrepository>((ref) {
  return Ordersrepository();
});
