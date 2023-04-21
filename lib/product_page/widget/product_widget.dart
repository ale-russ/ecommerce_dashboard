import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/constants.dart';
import '../../models/product.dart';
import '../../widget/image_widget.dart';
import '../screens/products_detali.dart';
import 'add_product.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
    required this.prod,
  });

  final Product prod;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.goNamed('product-details', extra: prod);
        // Navigator.push(context, MaterialPageRoute(
        //   builder: (context) {
        //     return ProductDetailsPage(
        //       product: prod,
        //     );
        //   },
        // ));
      },
      child: Container(
        width: 200,
        height: double.infinity,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: secondaryColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Imagewidget(
              imageurl: prod.imageURL,
            ),
            const SizedBox(height: xsPadding),
            DescText(name: prod.name!),
            DescText(
              name: prod.price!,
              color: Colors.green,
              isPrice: true,
            ),
          ],
        ),
      ),
    );
  }
}

class AddProductButton extends StatelessWidget {
  const AddProductButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: TextButton(
        onPressed: () {
          context.goNamed('add-products');
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => const AddProductPage()));
        },
        child: const Text(
          'Add product',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class DescText extends StatelessWidget {
  const DescText({
    super.key,
    required this.name,
    this.color = Colors.white,
    this.isPrice = false,
  });

  final String name;
  final Color color;
  final bool isPrice;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isPrice)
            const Text(
              '\$',
              style: TextStyle(
                color: Colors.green,
                fontSize: 16,
              ),
            ),
          Expanded(
            child: Text(
              name,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontSize: 16,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
