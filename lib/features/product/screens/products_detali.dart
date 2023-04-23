import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/custome_appbar.dart';
import '../../models/product.dart';

class ProductDetailsPage extends ConsumerWidget {
  const ProductDetailsPage({Key? key, this.product}) : super(key: key);

  final Product? product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(
        title: product!.name,
        isCenterTile: true,
      ),
      // appBar: AppBar(
      //   title: Text(product!.name!),
      //   centerTitle: true,
      // ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          Container(
            height: 200,
            width: 350,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(0.1)),
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    image: NetworkImage(
                      product!.imageURL!,
                    ),
                    fit: BoxFit.cover)),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 300),
                  child: Text(
                    product!.name!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '\$${product!.price!}',
                  style: const TextStyle(color: Colors.green),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
