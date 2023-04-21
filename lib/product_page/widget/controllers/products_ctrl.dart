import 'package:ecommerce_dashboard/models/orders.dart';
import 'package:ecommerce_dashboard/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../products_repo.dart';

class Productscontrollers {
  Productscontrollers({required this.ref});
  final Ref ref;

  Stream<List<Product>> watchProductList() {
    try {
      return ref.read(productsRepositoryProvider).productslist();
    } catch (e) {
      throw ('Something went wrong here....');
    }
  }
}

final productscontrollerProvider = Provider<Productscontrollers>((ref) {
  return Productscontrollers(ref: ref);
});
final productsprovider = StreamProvider<List<Product>>((ref) {
  return ref.read(productscontrollerProvider).watchProductList();
});
