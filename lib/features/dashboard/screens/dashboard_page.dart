import 'package:ecommerce_dashboard/features/constants/constants.dart';
import 'package:ecommerce_dashboard/features/dashboard/controllers/dashboard_ctrl.dart';
import 'package:ecommerce_dashboard/features/dashboard/widget/card_widget.dart';
import 'package:ecommerce_dashboard/features/models/orders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common_widget/error_widget.dart';
import '../../constants/custome_appbar.dart';

class Dashboardpage extends ConsumerStatefulWidget {
  const Dashboardpage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardpageState();
}

class _DashboardpageState extends ConsumerState<Dashboardpage> {
  final User users = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(allordersprovider);
    final packing = ref.watch(packingprovider);
    final delivered = ref.watch(deliveredprovider);
    final completed = ref.watch(completedprovider);

    var isLoading = orders.isLoading ||
        packing.isLoading ||
        delivered.isLoading ||
        completed.isLoading;
    return Scaffold(
        appBar: CustomAppBar(users: users, title: 'Dashboard'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: isLoading
              ? Center(
                  child: const CircularProgressIndicator(
                    color: Colors.amber,
                  ),
                )
              : Column(
                  children: [
                    const SizedBox(height: defaultPadding),
                    Row(
                      children: [
                        buildDashboard(orders),
                        const SizedBox(width: defaultPadding),
                        buildDashboard(packing),
                      ],
                    ),
                    const SizedBox(height: defaultPadding),
                    Row(
                      children: [
                        buildDashboard(delivered),
                        const SizedBox(width: defaultPadding),
                        buildDashboard(completed),
                      ],
                    ),
                  ],
                ),
        ));
  }

  Widget buildDashboard(AsyncValue<List<Orders>> orderLists) {
    return orderLists.when(
      data: (data) {
        return Dashboardwidget(
          title: 'All orders',
          count: data.length,
          value: data.length / 4,
        );
      },
      error: (Object error, StackTrace stackTrace) {
        return AdminErrorWidget(message: error.toString());
      },
      loading: () {
        return SizedBox.shrink();
        // return Center(child: const LoadingWidget());
      },
    );
  }
}
