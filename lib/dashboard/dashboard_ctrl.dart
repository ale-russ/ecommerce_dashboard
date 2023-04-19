import 'package:ecommerce_dashboard/dashboard/dashboard_repo.dart';
import 'package:ecommerce_dashboard/models/orders.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Dashboardcontrollers {
  Dashboardcontrollers({required this.ref});
  final Ref ref;

  Stream<List<orders>> watchorderlist() {
    try {
      return ref.read(DashboardRepositoryProvider).orderlist();
    } catch (e) {
      throw ('Something went wrong here....');
    }
  }

  Stream<List<orders>> watcpackinglist() {
    try {
      return ref.read(DashboardRepositoryProvider).packinglist();
    } catch (e) {
      throw ('Something went wrong here....');
    }
  }

  Stream<List<orders>> watchdeliverdist() {
    try {
      return ref.read(DashboardRepositoryProvider).deliveredlist();
    } catch (e) {
      throw ('Something went wrong here....');
    }
  }

  Stream<List<orders>> watchcompletedlist() {
    try {
      return ref.read(DashboardRepositoryProvider).completedlist();
    } catch (e) {
      throw ('Something went wrong here....');
    }
  }
}

final DashboardcontrollersProvider = Provider<Dashboardcontrollers>((ref) {
  return Dashboardcontrollers(ref: ref);
});
final allordersprovider = StreamProvider<List<orders>>((ref) {
  return ref.read(DashboardcontrollersProvider).watchorderlist();
});
final packingprovider = StreamProvider<List<orders>>((ref) {
  return ref.read(DashboardcontrollersProvider).watcpackinglist();
});
final deliveredprovider = StreamProvider<List<orders>>((ref) {
  return ref.read(DashboardcontrollersProvider).watchdeliverdist();
});
final completedprovider = StreamProvider<List<orders>>((ref) {
  return ref.read(DashboardcontrollersProvider).watchcompletedlist();
});
