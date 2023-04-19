import 'package:ecommerce_dashboard/constants/constants.dart';
import 'package:ecommerce_dashboard/product_page/products_ctrl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widget/error_widget.dart';
import 'widget/product_widget.dart';

class Productpage extends ConsumerWidget {
  Productpage({Key? key}) : super(key: key);

  final User users = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsprovider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        title: const Text('Products'),
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
          return Container(
            height: double.infinity,
            child: ListView(
              children: [
                const AddProductButton(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: GridView.builder(
                    itemCount: data.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 8),
                    itemBuilder: (context, index) {
                      return ProductWidget(
                        prod: data[index],
                      );
                    },
                  ),
                )
              ],
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
