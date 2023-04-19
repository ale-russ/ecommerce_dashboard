import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_dashboard/constants/constants.dart';
import 'package:ecommerce_dashboard/orders_page/orders_ctrl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widget/admin_appbar.dart';
import '../widget/error_widget.dart';
import '../widget/table_orders.dart';

class Orderpage extends ConsumerStatefulWidget {
  const Orderpage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderpageState();
}

class _OrderpageState extends ConsumerState<Orderpage> {
  final User users = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(ordersprovider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        title: Text('orders'),
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
      body: orders.when(
        data: (data) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: PageView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                var container = Container(
                  height: 250,
                  // constraints: BoxConstraints(minHeight: 250),
                  child: ListView.separated(
                    itemCount: data.length,
                    itemBuilder: (constext, index) {
                      return Tableorders(
                        cell1: data[index].orderId,
                        cell2: data[index].orderDate,
                        cell3: data[index].status,
                        cell4: data[index].totalPrice,
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                  ),
                );
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: defaultPadding * 2,
                    ),
                    const Tableorders(
                      cell1: 'orderId',
                      cell2: 'orderDate',
                      cell3: 'status',
                      cell4: 'price',
                    ),
                    const SizedBox(height: defaultPadding),

                    container
                    // for (var ord in data)
                    //   Tableorders(
                    //     cell1: ord.orderId,
                    //     cell2: ord.orderDate,
                    //     cell3: ord.status,
                    //     cell4: ord.totalPrice,
                    //   ),
                  ],
                );
              },
            ),
          );
        },
        error: (Object error, StackTrace stackTrace) {
          return adminErrorWidget(message: error.toString());
        },
        loading: () {
          return const LoadingWidget();
        },
      ),
    );
  }
}
