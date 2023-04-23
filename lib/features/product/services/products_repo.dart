import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_dashboard/features/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Productsepository {
  Stream<List<Product>> productslist() {
    try {
      final data =
          FirebaseFirestore.instance.collection('products').snapshots().map(
                (snapshot) => snapshot.docs
                    .map((doc) => Product.fromMap(doc.data()))
                    .toList(),
              );
      return data;
    } catch (e) {
      throw ('Something went wrong here....');
    }
  }
}

final productsRepositoryProvider = Provider<Productsepository>((ref) {
  return Productsepository();
});
