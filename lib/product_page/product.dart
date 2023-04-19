import 'package:ecommerce_dashboard/constants/constants.dart';
import 'package:ecommerce_dashboard/product_page/products_ctrl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widget/error_widget.dart';
import 'widget/product_widget.dart';

class Productpage extends ConsumerStatefulWidget {
  const Productpage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductpageState();
}

class _ProductpageState extends ConsumerState<Productpage> {
  final User users = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productsprovider);

    return Padding(
        padding: const EdgeInsets.all(16),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: secondaryColor,
            title: const Text('product'),
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
          body: products.when(
            data: (data) {
              return PageView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const addproductbutton(),
                        const SizedBox(height: defaultPadding),
                        for (var prod in data) productwidget(prod: prod),
                      ],
                    ),
                  );
                },
              );
            },
            error: (Object error, StackTrace stackTrace) {
              return adminErrorWidget(message: error.toString());
            },
            loading: () {
              return const LoadingWidget();
            },
          ),
        ));
  }
}
