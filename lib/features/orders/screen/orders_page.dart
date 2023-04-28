import 'dart:developer';

import 'package:ecommerce_dashboard/features/constants/constants.dart';
import 'package:ecommerce_dashboard/features/orders/controllers/orders_ctrl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common_widget/error_widget.dart';
import '../../constants/custome_appbar.dart';
import '../widget/table_orders.dart';

class OrderPage extends ConsumerStatefulWidget {
  const OrderPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderPageState();
}

class _OrderPageState extends ConsumerState<OrderPage> {
  final User users = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(ordersprovider);

    return Scaffold(
      appBar: CustomAppBar(users: users, title: 'Orders'),
      body: orders.when(
        data: (data) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: PageView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: defaultPadding * 2,
                    ),
                    Tableorders(
                      cell1: 'OrderId',
                      cell2: 'OrderDate',
                      cell3: 'Status',
                      cell4: 'Price',
                    ),
                    const SizedBox(height: defaultPadding),
                    SizedBox(
                      height: 250,
                      // constraints: BoxConstraints(minHeight: 250),
                      child: ListView.separated(
                        itemCount: data.length,
                        itemBuilder: (constext, index) {
                          var status = data[index].status![0].toUpperCase() +
                              data[index].status!.substring(1);
                          return Tableorders(
                            cell1: data[index].orderId,
                            cell2: data[index].orderDate,
                            cell3: status,
                            cell4: '${data[index].totalPrice} \$',
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                      ),
                    )
                  ],
                );
              },
            ),
          );
        },
        error: (Object error, StackTrace stackTrace) {
          return AdminErrorWidget(message: error.toString());
        },
        loading: () {
          return const LoadingWidget();
        },
      ),
    );
  }
}
