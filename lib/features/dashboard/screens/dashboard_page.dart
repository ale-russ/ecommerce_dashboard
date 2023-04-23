import 'package:ecommerce_dashboard/features/constants/constants.dart';
import 'package:ecommerce_dashboard/features/dashboard/controllers/dashboard_ctrl.dart';
import 'package:ecommerce_dashboard/features/dashboard/widget/card_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common_widget/error_widget.dart';

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

    return Scaffold(
        appBar: AppBar(
          backgroundColor: secondaryColor,
          title: const Text('Dashboard'),
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  '${users.email}',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              const SizedBox(height: defaultPadding),
              Row(
                children: [
                  orders.when(
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
                      return const LoadingWidget();
                    },
                  ),
                  const SizedBox(width: defaultPadding),
                  packing.when(
                    data: (data) {
                      return Dashboardwidget(
                        textcontainercolor: packcolor,
                        title: 'packing',
                        count: data.length,
                        value: data.length / 4,
                      );
                    },
                    error: (Object error, StackTrace stackTrace) {
                      return AdminErrorWidget(message: error.toString());
                    },
                    loading: () {
                      return const LoadingWidget();
                    },
                  )
                ],
              ),
              const SizedBox(height: defaultPadding),
              Row(
                children: [
                  delivered.when(
                    data: (data) {
                      return Dashboardwidget(
                        textcontainercolor: delivercolor,
                        title: 'delivered',
                        count: data.length,
                        value: data.length / 4,
                      );
                    },
                    error: (Object error, StackTrace stackTrace) {
                      return AdminErrorWidget(message: error.toString());
                    },
                    loading: () {
                      return const LoadingWidget();
                    },
                  ),
                  const SizedBox(width: defaultPadding),
                  completed.when(
                    data: (data) {
                      return Dashboardwidget(
                        textcontainercolor: compcolor,
                        title: 'completed',
                        count: data.length,
                        value: data.length / 4,
                      );
                    },
                    error: (Object error, StackTrace stackTrace) {
                      return AdminErrorWidget(message: error.toString());
                    },
                    loading: () {
                      return const LoadingWidget();
                    },
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
