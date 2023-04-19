import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../models/product.dart';
import '../../widget/image_widget.dart';
import '../add_product.dart';

class productwidget extends StatelessWidget {
  const productwidget({
    super.key,
    required this.prod,
  });

  final Product prod;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: EdgeInsets.all(8),
      color: secondaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Imagewidget(
            imageurl: prod.imageURL,
          ),
          const SizedBox(height: xsPadding),
          desctext(name: prod.name!),
          desctext(name: prod.price!),
        ],
      ),
    );
  }
}

class addproductbutton extends StatelessWidget {
  const addproductbutton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: TextButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Addproduct()));
        },
        child: Text('add product', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class desctext extends StatelessWidget {
  const desctext({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Align(
          alignment: Alignment.centerLeft,
          child:
              Text(name, style: TextStyle(fontSize: 16, color: Colors.white))),
    );
  }
}
