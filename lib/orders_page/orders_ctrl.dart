import 'package:ecommerce_dashboard/models/orders.dart';
import 'package:ecommerce_dashboard/orders_page/orders_repo.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class Ordercontrollers {
  Ordercontrollers({required this.ref});
  final Ref ref;

  Stream<List<Orders>> watchorderlist() {
    try {
      return ref.read(ordersRepositoryProvider).orderlist();
    } catch (e) {
      throw ('Something went wrong here....');
    }
  }
}

final orderscontrollerProvider = Provider<Ordercontrollers>((ref) {
  return Ordercontrollers(ref: ref);
});
final ordersprovider = StreamProvider<List<Orders>>((ref) {
  return ref.read(orderscontrollerProvider).watchorderlist();
});
